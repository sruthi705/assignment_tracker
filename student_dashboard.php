<?php
session_start();
include("db.php");

// Authentication
if (!isset($_SESSION['username']) || strtolower($_SESSION['role']) !== "student") {
    header("Location: index.php");
    exit;
}

$usn = $_SESSION['username'];

// Fetch student data & semester
$name_query = $conn->query("SELECT name, sem FROM student WHERE usn='$usn'");
$student_data = $name_query->fetch_assoc();
$student_name = $student_data['name'] ?? $usn;
$student_sem_display = $student_data['sem'] ?? 0;

if ($student_sem_display < 1) {
    $usn_year_part = substr($usn, 3, 2);
    $admission_year = 2000 + intval($usn_year_part);
    $current_year = date('Y');
    $current_month = date('n');
    $years_elapsed = $current_year - $admission_year;

    $student_sem_display = ($current_month >= 9 || $current_month <= 2) ? ($years_elapsed * 2 + 1) : ($years_elapsed * 2);
    $student_sem_display = max(1, min(8, $student_sem_display));
}

$sem_number = $student_sem_display;

// Fetch subjects
$subjects = [];
$stmt = $conn->prepare("SELECT DISTINCT name FROM scheme WHERE sem = ? ORDER BY name ASC");
$stmt->bind_param("i", $sem_number);
$stmt->execute();
$res = $stmt->get_result();
while ($row = $res->fetch_assoc()) $subjects[] = $row['name'];
$stmt->close();

// Fetch assignment types
$assignment_types = [];
$typ = $conn->query("SELECT assignment_type FROM assignment_types");
while ($row = $typ->fetch_assoc()) $assignment_types[] = $row['assignment_type'];

// Delete assignment
if (isset($_GET['delete']) && is_numeric($_GET['delete'])) {
    $assignment_id = intval($_GET['delete']);
    $fetch = $conn->prepare("SELECT file_path FROM assignments WHERE id=? AND usn=?");
    $fetch->bind_param("is", $assignment_id, $usn);
    $fetch->execute();
    $fres = $fetch->get_result();

    if ($fres->num_rows > 0) {
        $path = $fres->fetch_assoc()['file_path'];
        if (file_exists($path) && strpos(realpath($path), realpath("uploads")) === 0) {
            unlink(realpath($path));
        }
        $del = $conn->prepare("DELETE FROM assignments WHERE id=? AND usn=?");
        $del->bind_param("is", $assignment_id, $usn);
        $del->execute();
        $del->close();
    }
    $fetch->close();
    header("Location: student_dashboard.php");
    exit;
}

// Upload assignment
$message = "";
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save'])) {
    $subject = $_POST['subject'];
    $atype = $_POST['assignment_type'];
    $anum = intval($_POST['assignment_no']);
    $file = $_FILES['assignment_file'];

    $check_stmt = $conn->prepare("SELECT id FROM assignments WHERE usn=? AND semester=? AND subject=? AND assignment_no=?");
    $check_stmt->bind_param("sisi", $usn, $sem_number, $subject, $anum);
    $check_stmt->execute();
    $existing_record = $check_stmt->get_result();
    $check_stmt->close();

    if ($existing_record->num_rows > 0) {
        $message = "Error: Assignment $anum for $subject has already been uploaded. Please delete it first.";
    } elseif ($file['error'] === 0) {
        $dir = "uploads/$usn/";
        if (!is_dir($dir)) mkdir($dir, 0777, true);
        $fname = time() . "_" . basename($file['name']);
        $tgt = $dir . $fname;

        if (move_uploaded_file($file['tmp_name'], $tgt)) {
            $sid = $conn->query("SELECT id FROM student WHERE usn='$usn'")->fetch_assoc()['id'] ?? null;
            $stmt = $conn->prepare("INSERT INTO assignments (usn, student_id, subject, assignment_type, assignment_no, file_path, semester) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("sissssi", $usn, $sid, $subject, $atype, $anum, $tgt, $sem_number);
            $message = $stmt->execute() ? "File uploaded successfully!" : "Error inserting record: " . $conn->error;
            $stmt->close();
        } else {
            $message = "Error: Failed to move uploaded file.";
        }
    } elseif ($file['error'] !== 4) {
        $message = "File upload error: code " . $file['error'];
    }
}

// Fetch uploaded assignments
$assignments = [];
$q = $conn->prepare("SELECT id, subject, assignment_type, assignment_no, file_path FROM assignments WHERE usn=? AND semester=? ORDER BY subject, assignment_no");
$q->bind_param("si", $usn, $sem_number);
$q->execute();
$r = $q->get_result();

while ($row = $r->fetch_assoc()) {
    $sub = $row['subject'];
    if (!isset($assignments[$sub])) $assignments[$sub] = [1=>['assignment_type'=>'Not Uploaded','id'=>null,'file_path'=>null], 2=>['assignment_type'=>'Not Uploaded','id'=>null,'file_path'=>null]];
    $anum = intval($row['assignment_no']);
    if ($anum==1 || $anum==2) $assignments[$sub][$anum] = ['id'=>$row['id'],'assignment_type'=>$row['assignment_type'],'file_path'=>$row['file_path']];
}
$q->close();
?>

<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
body{margin:0;font-family:Arial;background:linear-gradient(135deg,#7F7BFF,#E26D9A);padding:15px;font-size:16px;}
.container{width:98%;margin:auto;background:#ffffffdd;padding:25px;border-radius:14px;box-shadow:0 10px 25px rgba(0,0,0,0.15);box-sizing:border-box;}
.header{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;padding-bottom:8px;border-bottom:1px solid #eee;}
.header h1{margin:0;font-size:28px;}
.welcome{margin:15px 0 18px;color:#444;font-size:18px;}
h2{margin:20px 0 10px;font-size:24px;}
.message-box{margin:12px 0;padding:8px;border-radius:4px;font-size:14px;}
.message-success{background:#d4ffd4;border:1px solid #c3e6cb;}
.message-error{background:#ffe0e0;border:1px solid #f5c6cb;color:#721c24;}
.logout{padding:8px 12px;background:#dc3545;color:#fff !important;text-decoration:none;border-radius:5px;font-size:1em;transition:background 0.3s;}
.logout:hover{background:#c82333;}
select,input[type=file],.upload-grid input[type=radio]{width:100%;padding:10px;background:#eef3ff;border:1px solid #ccc;border-radius:4px;margin-top:5px;font-size:16px;box-sizing:border-box;}
label{font-size:16px;margin-bottom:4px;display:block;}
.upload-grid input[type=radio]{width:auto;display:inline-block;margin-top:0;margin-right:5px;font-size:16px;}
.upload-grid label[for^="a"]{width:auto;display:inline-block;margin-right:15px;font-size:16px;}
.upload-grid div:nth-child(3) > br{display:none;}
.upload-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-top:15px;}
.btn-save{background:#28a745;color:white;padding:12px;border-radius:4px;border:none;width:100%;font-size:18px;margin-top:20px;cursor:pointer;}
table{margin-top:15px;width:100%;background:white;border-collapse:collapse;border-radius:8px;overflow:hidden;}
th{padding:12px;background:#7F7BFF;color:white;text-align:left;font-size:16px;}
td{padding:12px;border-bottom:1px solid #eee;font-size:16px;}
td a{margin-top:8px;margin-bottom:0;}
.btn-view,.btn-delete{padding:6px 10px;border-radius:4px;color:white;text-decoration:none;font-size:14px;display:inline-block;margin-right:6px;}
.btn-view{background:#17a2b8;}
.btn-delete{background:#dc3545;}
@media(max-width:768px){body{padding:10px;}.container{padding:15px;width:100%;}.header{flex-direction:column;align-items:flex-start;}.logout{margin-top:10px;}.upload-grid{grid-template-columns:1fr;}td{padding:10px;}}
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Student Dashboard</h1>
        <a href="logout.php" class="logout">Logout</a>
    </div>
    <p class="welcome">
        Welcome <strong><?= $student_name ?></strong> (USN: <?= $usn ?>) — Semester <strong><?= $student_sem_display ?></strong>
    </p>

    <?php if($message): $msg_class = (strpos($message,'Error')!==false)?"message-error":"message-success"; ?>
        <p class="message-box <?= $msg_class ?>"><?= $message ?></p>
    <?php endif; ?>

    <h2>Upload Assignment</h2>
    <form method="POST" enctype="multipart/form-data">
        <div class="upload-grid">
            <div>
                <label>Subject</label>
                <select name="subject" required>
                    <option value="">Select Subject</option>
                    <?php foreach($subjects as $s): ?><option value="<?= $s ?>"><?= $s ?></option><?php endforeach; ?>
                </select>
            </div>
            <div>
                <label>Assignment Type</label>
                <select name="assignment_type" required>
                    <option value="">Select Type</option>
                    <?php foreach($assignment_types as $t): ?><option value="<?= $t ?>"><?= $t ?></option><?php endforeach; ?>
                </select>
            </div>
            <div>
                <label>Assignment No</label><br>
                <input type="radio" name="assignment_no" value="1" id="a1" required> <label for="a1">1</label>
                <input type="radio" name="assignment_no" value="2" id="a2" required> <label for="a2">2</label>
            </div>
            <div>
                <label>Choose File</label>
                <input type="file" name="assignment_file" required>
            </div>
        </div>
        <button type="submit" name="save" class="btn-save">Upload</button>
    </form>

    <h2 style="margin-top:25px;">Uploaded Assignments</h2>
    <table>
        <tr><th>Subject</th><th>Assignment 1</th><th>Assignment 2</th></tr>
        <?php if(empty($assignments)): ?>
            <tr><td colspan="3" style="text-align:center;color:#777;font-style:italic;">No assignments uploaded for Semester <?= $student_sem_display ?>.</td></tr>
        <?php else: foreach($assignments as $sub=>$data): ?>
            <tr>
                <td><strong><?= $sub ?></strong></td>
                <td>
                    <?php if($data[1]['id']!==null): ?>
                        <?= htmlspecialchars($data[1]['assignment_type']) ?><br>
                        <a class="btn-view" href="<?= htmlspecialchars($data[1]['file_path']) ?>" target="_blank">View</a>
                        <a class="btn-delete" href="?delete=<?= $data[1]['id'] ?>" onclick="return confirm('Delete Assignment 1 for <?= htmlspecialchars($sub) ?>?')">Delete</a>
                    <?php else: ?>
                        <em style="color:#777;">Not Uploaded</em>
                    <?php endif; ?>
                </td>
                <td>
                    <?php if($data[2]['id']!==null): ?>
                        <?= htmlspecialchars($data[2]['assignment_type']) ?><br>
                        <a class="btn-view" href="<?= htmlspecialchars($data[2]['file_path']) ?>" target="_blank">View</a>
                        <a class="btn-delete" href="?delete=<?= $data[2]['id'] ?>" onclick="return confirm('Delete Assignment 2 for <?= htmlspecialchars($sub) ?>?')">Delete</a>
                    <?php else: ?>
                        <em style="color:#777;">Not Uploaded</em>
                    <?php endif; ?>
                </td>
            </tr>
        <?php endforeach; endif; ?>
    </table>
</div>
</body>
</html>
