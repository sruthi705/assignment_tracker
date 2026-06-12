<?php
// FIX: Hide PHP warnings from the front end (errors are still logged)
error_reporting(E_ALL & ~E_NOTICE & ~E_WARNING & ~E_DEPRECATED); 
ini_set('display_errors', 0);

session_start();
include("db.php");

// AUTH CHECK: Use strtolower() for case-insensitive role check
if (!isset($_SESSION['username']) || strtolower($_SESSION['role']) !== 'teacher') {
    header("Location: index.php");
    exit;
}

$teacher_name = $_SESSION['name'];

// ---------------- FILTERS ----------------
$filter_clauses = [];
$filter_types = '';
$filter_params = [];

$selected_semester = $_GET['semester'] ?? "";
$selected_subject = $_GET['subject'] ?? "";
$selected_type = $_GET['assignment_type'] ?? "";

if (!empty($selected_semester)) {
    $filter_clauses[] = "a.semester = ?";
    $filter_types .= "s";
    $filter_params[] = $selected_semester;
}
if (!empty($selected_subject)) {
    $filter_clauses[] = "a.subject = ?";
    $filter_types .= "s";
    $filter_params[] = $selected_subject;
}
if (!empty($selected_type)) {
    $filter_clauses[] = "a.assignment_type = ?";
    $filter_types .= "s";
    $filter_params[] = $selected_type;
}

$where_clause = empty($filter_clauses) ? "1=1" : implode(" AND ", $filter_clauses);

// ------------- FETCH ASSIGNMENTS (USING PREPARED STATEMENT) -------------
$query = "
    SELECT a.*, s.name AS student_name, s.usn 
    FROM assignments a
    JOIN student s ON a.usn = s.usn
    WHERE $where_clause
    ORDER BY a.semester, a.subject, a.assignment_no
";

$stmt = $conn->prepare($query);

if (!empty($filter_params)) {
    $stmt->bind_param($filter_types, ...$filter_params);
}

$stmt->execute();
$result = $stmt->get_result();

// ------------- SEMESTERS FROM scheme -------------
$semesters = $conn->query("SELECT DISTINCT sem FROM scheme ORDER BY sem ASC");

// ------------- SUBJECTS (FOR INITIAL LOAD/FILTERED LOAD) -------------
$subjects_sql = "SELECT DISTINCT name FROM scheme";
$subject_params = [];
$subject_types = '';

if (!empty($selected_semester)) {
    $subjects_sql .= " WHERE sem=?"; 
    $subject_types .= "s";
    $subject_params[] = $selected_semester;
}
$subjects_sql .= " ORDER BY name";

$subj_stmt = $conn->prepare($subjects_sql);
if (!empty($subject_params)) {
    $subj_stmt->bind_param($subject_types, ...$subject_params);
}
$subj_stmt->execute();
$subjects_result = $subj_stmt->get_result();


// ------------- TYPES -------------
$types = $conn->query("SELECT * FROM assignment_types ORDER BY assignment_type ASC");

// ------------- GROUP ASSIGNMENTS -------------
$grouped = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $sem = $row['semester'];
        $usn = $row['usn'];
        $sub = $row['subject'];
        $grouped[$sem][$usn][$sub][$row['assignment_no']] = $row;
    }
}
$stmt->close();
$subj_stmt->close();

// ------------- PIE GRAPH VALUES (MODIFIED FOR ALL/SPECIFIC SEMESTER) -------------
$assign1 = 0;
$assign2 = 0;

// Determine where clause for semester counting
$where_sem_clause = !empty($selected_semester) ? "WHERE semester = ?" : "WHERE 1=1";
$param_value = $selected_semester;

// The WHERE 1=1 is needed to safely add the AND assignment_no=X part in the subqueries
$count_query = "SELECT 
    (SELECT COUNT(*) FROM assignments $where_sem_clause AND assignment_no=1) AS c1,
    (SELECT COUNT(*) FROM assignments $where_sem_clause AND assignment_no=2) AS c2";

$count_stmt = $conn->prepare($count_query);

if (!empty($selected_semester)) {
    // Bind the parameter twice since it appears twice in the query
    $count_stmt->bind_param("ss", $param_value, $param_value); 
}

$count_stmt->execute();
$counts = $count_stmt->get_result()->fetch_assoc();

$assign1 = $counts['c1'];
$assign2 = $counts['c2'];
$count_stmt->close();

// Calculate total assignments for the chart area
$total_assignments = $assign1 + $assign2;
?>

<!DOCTYPE html>
<html>
<head>
<title>Teacher Dashboard</title>

<script src="https://www.gstatic.com/charts/loader.js"></script>

<style>
/* --- CORE DASHBOARD STYLES (HOD THEME) --- */
body { 
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
    /* INCREASE BASE FONT SIZE */
    font-size: 17px; 
    /* HOD Gradient Background */
    background: linear-gradient(135deg, #7F7BFF, #E26D9A); 
    margin:0; 
    padding:20px; 
    display: flex;
    justify-content: center;
    align-items: flex-start; 
    min-height: 100vh;
}
.container {
    /* HOD Container Background/Shadow */
    background: #ffffffd9; 
    padding:30px; 
    border-radius:14px; 
    box-shadow: 0px 10px 25px rgba(0,0,0,0.15); 
    max-width:1400px; 
    width: 95%;
    margin-top: 30px; 
}

h2 { 
    /* INCREASE H2 SIZE */
    font-size: 2.2em;
    margin-top:0; 
    color: #222; /* Dark color for headings */
}
h3 {
     /* INCREASE H3 SIZE */
    font-size: 1.5em;
    margin-top:0;
    color: #222;
}

/* Header Bar - Consistent with HOD look */
.header-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    padding-bottom: 15px;
    border-bottom: 2px solid #eee; /* Light divider */
}

.btn-logout {
    /* Consistent with HOD Logout Button */
    background:#dc3545; 
    color:white; 
    padding:12px 24px; /* Slightly larger button */
    border-radius:6px; 
    text-decoration:none;
    font-weight: bold;
    transition: background-color 0.3s;
}
.btn-logout:hover { background:#c82333; }

/* Filter & Input Styling - Consistent with HOD form elements */
.filters {
    display:flex;
    flex-wrap: wrap;
    gap:25px; /* Increased gap */
    margin-bottom:30px;
    align-items:center;
    padding: 18px; /* Increased padding */
    /* Consistent background for the filter bar */
    background: #ffffff; 
    border-radius: 8px;
    border: 1px solid #d4d4d4;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1); 
}

.filters label {
    font-weight: bold;
    color: #555;
    font-size: 1.1em; /* Increased label size */
}

.filters select, .filters input[type="text"] {
    padding:12px 18px; /* Larger input/select */
    border-radius:6px;
    /* Consistent input border */
    border:1px solid #d4d4d4; 
    font-size:16px; /* Increased input text size */
    /* Consistent input background */
    background: #eef3ff; 
    box-sizing: border-box;
    transition: border-color 0.3s;
}

.filters select:focus, .filters input[type="text"]:focus {
    /* Consistent Focus color */
    border-color: #7F7BFF; 
    outline: none;
    box-shadow: 0 0 5px rgba(127, 123, 255, 0.5);
}

#searchInput {
    flex:1;
    max-width:350px;
}

/* --- DASHBOARD CONTENT STYLES (Keep Functional) --- */

.flex-container {
    display:flex; 
    gap:25px;
    margin-top:20px;
    flex-wrap: wrap;
}

.chart-card, .table-card {
    /* Consistent Card style */
    background: #ffffff;
    padding:30px; /* Increased padding */
    border-radius:10px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1); 
    min-width:320px;
    flex:1;
    text-align:center;
    border: 1px solid #f0f0f0;
}

.chart-card {
    flex: 2; /* Chart takes 2 parts of the flexible space */
}

.table-card {
    flex: 3; /* Table takes 3 parts of the flexible space (giving a 2:3 ratio) */
    overflow-x:auto;
    text-align: left; 
}

/* Table Styling */
table { 
    width:100%; 
    border-collapse:collapse; 
    margin-top:15px; /* Increased margin */
    font-size:16px; /* Increased table base font size */
    border-radius: 8px; 
    overflow: hidden; 
}
th, td { 
    padding:12px 10px; /* Increased cell padding */
    border: 1px solid #ddd; 
    text-align:center; 
}
th { 
    /* Header color is HOD primary purple */
    background:#7F7BFF; 
    color:white; 
    font-weight: 600;
}
tbody tr:nth-child(even) { background:#fbf5ff; } 
tbody tr:hover { background:#eef3ff; } 

/* Final cell styling */
td:last-child, th:last-child {
    border-right: 1px solid #ddd; 
}

.btn-view { 
    /* Consistent with HOD Download button color */
    background:#28a745; 
    color:white; 
    padding:8px 16px; /* Slightly larger view button */
    border-radius:4px; 
    text-decoration:none; 
    display:inline-block; 
    margin-top:5px;
    font-size: 14px; /* Smallest text should still be readable */
    transition: background-color 0.3s;
}
.btn-view:hover { background:#1f7a34; }

/* File Missing warning */
.table-card span[style*="color:#ffc107"], .table-card span[style*="color:#f0ad4e"] {
    /* HOD orange/yellow for file missing */
    color: #f0ad4e !important; 
    font-weight: bold;
}

/* New style for the No Submissions message */
.no-submissions-msg {
    color: #dc3545;
    font-weight: bold;
    font-size: 1.5em; /* Increased message size */
    padding-top: 50px;
    padding-bottom: 50px;
}


@media (max-width: 768px) {
    .flex-container {
        flex-direction: column;
    }
    .filters {
        flex-direction: column;
        align-items: stretch;
    }
    .filters label {
        margin-top: 10px;
    }
}
</style>
</head>

<body>

<div class="container">

<div class="header-bar">
    <h2>👩‍🏫 Welcome, <?= htmlspecialchars($teacher_name); ?></h2>
    <a href="logout.php" class="btn-logout">Logout</a>
</div>

<h3>📄 Uploaded Assignments</h3>

<form method="get" class="filters" id="filterForm">

    <label for="semester">Semester:</label>
    <select name="semester" id="semester">
        <option value="">All</option>
        <?php 
        if ($semesters) $semesters->data_seek(0);
        while ($s = $semesters->fetch_assoc()): ?>
            <option value="<?= $s['sem']; ?>" <?= ($selected_semester == $s['sem']) ? 'selected' : ''; ?>>
                <?= $s['sem']; ?>
            </option>
        <?php endwhile; ?>
    </select>

    <label for="subject">Subject:</label>
    <select name="subject" id="subject">
        <option value="">All</option>
        <?php while ($sub = $subjects_result->fetch_assoc()): ?>
             <option value="<?= htmlspecialchars($sub['name']); ?>" <?= ($selected_subject == $sub['name']) ? 'selected' : ''; ?>>
                 <?= htmlspecialchars($sub['name']); ?>
             </option>
        <?php endwhile; ?>
    </select>

    <label for="assignment_type">Assignment Type:</label>
    <select name="assignment_type" id="assignment_type">
        <option value="">All</option>
        <?php 
        if ($types) $types->data_seek(0);
        while ($t = $types->fetch_assoc()): ?>
            <option value="<?= htmlspecialchars($t['assignment_type']); ?>" <?= ($selected_type == $t['assignment_type']) ? 'selected' : ''; ?>>
                <?= htmlspecialchars($t['assignment_type']); ?>
            </option>
        <?php endwhile; ?>
    </select>

    <input type="text" id="searchInput" placeholder="Search USN, Name, Subject, Type…">
</form>

<div class="flex-container">

    
    <div class="chart-card">
        <h3>📊 Assignment Count 
            <?php if (!empty($selected_semester)): ?>
                (Sem <?= htmlspecialchars($selected_semester) ?>)
            <?php else: ?>
                (All Semesters)
            <?php endif; ?>
        </h3>
        
        <?php if ($total_assignments > 0): ?>
            <div id="piechart" style="width:100%; height:250px;"></div>
        <?php else: ?>
            <div id="piechart" style="width:100%; height:250px;" class="no-submissions-msg">
                No submissions found for the current filters.
            </div>
        <?php endif; ?>
    </div>
    

    <div class="table-card">
        <table id="assignmentTable">
            <thead>
            <tr>
                <th>S.No</th>
                <th>Semester</th>
                <th>Student</th>
                <th>USN</th>
                <th>Subject</th>
                <th style="font-size: 1.1em;">Assignment 1</th>
                <th style="font-size: 1.1em;">Assignment 2</th>
                </tr>
            </thead>
            <tbody id="tableBody">
            <?php
            $sno = 1;
            if (!empty($grouped)):
                foreach ($grouped as $sem => $students):
                    foreach ($students as $usn => $subjects):
                        foreach ($subjects as $subject => $assignments):
                            $student_name = reset($assignments)['student_name'];
            ?>
            <tr data-subject="<?= htmlspecialchars($subject) ?>" data-usn="<?= htmlspecialchars($usn) ?>" data-name="<?= htmlspecialchars($student_name) ?>" data-sem="<?= htmlspecialchars($sem) ?>">
                <td><?= $sno++ ?></td>
                <td><?= $sem ?></td>
                <td><?= htmlspecialchars($student_name) ?></td>
                <td><?= htmlspecialchars($usn) ?></td>
                <td><?= htmlspecialchars($subject) ?></td>

                <?php for ($i=1; $i<=2; $i++): ?>
                    <td>
                        <?php if (isset($assignments[$i])): 
                            $file_path = $assignments[$i]['file_path'] ?? '';
                        ?>
                            <span data-type="<?= htmlspecialchars($assignments[$i]['assignment_type']) ?>"><?= htmlspecialchars($assignments[$i]['assignment_type']) ?></span><br>
                            <?php if (!empty($file_path)): ?>
                                <a href="download.php?file=<?= urlencode($file_path) ?>" class="btn-view" target="_blank">View</a>
                            <?php else: ?>
                                <span style="color:#f0ad4e;">File Missing</span>
                            <?php endif; ?>
                        <?php else: ?>
                            <em>Not Uploaded</em>
                        <?php endif; ?>
                    </td>
                <?php endfor; ?>
            </tr>

            <?php endforeach; endforeach; endforeach; else: ?>
                <tr><td colspan="7">No Records Found</td></tr>
            <?php endif; ?>
            </tbody>
        </table>
    </div>

</div> </div> 
<script>
document.addEventListener('DOMContentLoaded', function() {
    const filterForm = document.getElementById('filterForm');
    const semesterSelect = document.getElementById('semester');
    const subjectSelect = document.getElementById('subject');
    const typeSelect = document.getElementById('assignment_type');
    const searchInput = document.getElementById('searchInput');

    // --- EVENT LISTENERS (Simplified to rely on PHP for full page state management) ---

    // 1. Semester change should trigger immediate form submission
    semesterSelect.addEventListener('change', function() {
        // When semester changes, reset subject and type filters before submitting to ensure clean new list fetch
        subjectSelect.value = ''; 
        typeSelect.value = '';
        filterForm.submit();
    });

    // 2. Subject change should trigger immediate form submission
    subjectSelect.addEventListener('change', function() {
        filterForm.submit();
    });

    // 3. Assignment Type change should trigger immediate form submission
    typeSelect.addEventListener('change', function() {
        filterForm.submit();
    });


    // 4. Handle Enter key press on the search input
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Enter' || event.keyCode === 13) {
            // Only prevent the search input from submitting the form
            if (document.activeElement === searchInput) {
                event.preventDefault();
                // Perform live search instead
                performSearch(); 
            } else if (document.activeElement.closest('#filterForm')) {
                // For other focused elements within the form (like a select), submit
                filterForm.submit();
            }
        }
    });
    
    // 5. Live Search functionality
    if (searchInput) {
        searchInput.addEventListener("keyup", performSearch);

        function performSearch() {
            let value = searchInput.value.toLowerCase();
            document.querySelectorAll("#tableBody tr").forEach(row => {
                // Check if the row text contains the search value
                row.style.display = row.innerText.toLowerCase().includes(value) ? "" : "none";
            });
        }
    }
});
</script>

<?php if ($total_assignments > 0): // Only include chart script if there is data ?>
<script>
google.charts.load('current', {packages:['corechart']});
google.charts.setOnLoadCallback(drawPie);

function drawPie() {
    var data = google.visualization.arrayToDataTable([
        ['Assignment', 'Count'],
        ['Assignment 1', <?= $assign1 ?>],
        ['Assignment 2', <?= $assign2 ?>]
    ]);

    // Use HOD theme colors for the chart slices
    var options = { 
        pieHole:0.35,
        colors: ['#7F7BFF', '#E26D9A', '#a569bd', '#e67e22', '#f39c12']
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart'));
    chart.draw(data, options);
}
</script>
<?php endif; ?>

</body>
</html>