<?php  
// Start session and include DB connection
session_start();
include("db.php");

// Check user role
if (!isset($_SESSION['username']) || $_SESSION['role'] !== "hod") {
    header("Location: index.php");
    exit;
}

$hod_name = $_SESSION['name'] ?? 'HOD';

// Get filters from GET params safely
$selected_sem = $_GET['semester'] ?? "";
$selected_subject = $_GET['subject'] ?? "";
$selected_type = $_GET['assignment_type'] ?? "";

// Escape filters for SQL
$sem_sql = $conn->real_escape_string($selected_sem);
$subject_sql = $conn->real_escape_string($selected_subject);
$type_sql = $conn->real_escape_string($selected_type);

// 1. Total students count (filtered by semester if selected)
$total_students_sql = "SELECT COUNT(*) AS cnt FROM student";
if ($selected_sem !== "") {
    $total_students_sql .= " WHERE sem = '$sem_sql'";
}
$total_students_result = $conn->query($total_students_sql);
$total_students = ($total_students_result && $total_students_result->num_rows > 0) 
    ? $total_students_result->fetch_assoc()['cnt'] 
    : 0;

// 2. Submitted count - distinct USNs from assignments matching filters
$where_conditions = [];
if ($selected_sem !== "") $where_conditions[] = "semester = '$sem_sql'";
if ($selected_subject !== "") $where_conditions[] = "subject = '$subject_sql'";
if ($selected_type !== "") $where_conditions[] = "assignment_type = '$type_sql'";
$where_sql = count($where_conditions) ? " WHERE " . implode(" AND ", $where_conditions) : "";

$submitted_sql = "SELECT COUNT(DISTINCT usn) AS cnt FROM assignments $where_sql";
$submitted_result = $conn->query($submitted_sql);
$submitted_students = ($submitted_result && $submitted_result->num_rows > 0)
    ? $submitted_result->fetch_assoc()['cnt']
    : 0;

// Pending count = total students - submitted (not less than zero)
$pending_students = max(0, $total_students - $submitted_students);

// Get assignment type counts for pie chart
$type_count = [];
$type_count_sql = "SELECT assignment_type, COUNT(*) AS total FROM assignments $where_sql GROUP BY assignment_type";
$type_count_result = $conn->query($type_count_sql);
if ($type_count_result) {
    while ($row = $type_count_result->fetch_assoc()) {
        $type_count[$row['assignment_type']] = (int)$row['total'];
    }
}

// RESTORING GROUPED STRUCTURE for Assignment 1 / Assignment 2 cell display
$grouped_records = [];
$records_sql = "SELECT a.*, s.name AS student_name FROM assignments a 
                JOIN student s ON a.usn = s.usn 
                $where_sql
                ORDER BY s.usn, a.subject, a.assignment_no";
$records_result = $conn->query($records_sql);
if ($records_result) {
    while ($row = $records_result->fetch_assoc()) {
        $key = $row['usn'] . '_' . $row['subject'];
        if (!isset($grouped_records[$key])) {
            $grouped_records[$key] = [
                'usn' => $row['usn'],
                'student_name' => $row['student_name'],
                'subject' => $row['subject'],
                'assignments' => [],
            ];
        }
        $grouped_records[$key]['assignments'][$row['assignment_no']] = [
            'type' => $row['assignment_type'],
            'file' => $row['file_path'] ?? '',
        ];
    }
}

// Fetch distinct semesters, subjects, assignment types for filters
$semesters = $conn->query("SELECT DISTINCT sem FROM scheme ORDER BY sem");
$subjects_sql = "SELECT DISTINCT name FROM scheme";
if ($selected_sem !== "") $subjects_sql .= " WHERE sem='$sem_sql'";
$subjects_sql .= " ORDER BY name";
$subjects = $conn->query($subjects_sql);
$types = $conn->query("SELECT DISTINCT assignment_type FROM assignment_types ORDER BY assignment_type");
?>
<!DOCTYPE html>
<html>
<head>
    <title>HOD Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
    <style>
        /* NEW STYLES FROM LOGIN PAGE */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #7F7BFF, #E26D9A);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            padding: 20px 0; /* Add vertical padding for content */
        }

        .main-content {
            width: 95%; 
            max-width: 1200px;
            background: #ffffffd9;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0px 10px 25px rgba(0,0,0,0.15);
        }

        /* HEADER: Ensure HOD title and Logout are separated */
        .header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 20px; 
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
        } 
        
        .header h2 {
            font-size: 24px;
            color: #222;
        }

        /* LOGOUT BUTTON */
        .logout { 
            padding: 8px 12px; 
            background: #dc3545; /* Red color */
            color: #fff; 
            text-decoration:none; 
            border-radius:5px;
            font-size: 0.9em; 
            transition: background 0.3s;
        }
        .logout:hover { background: #c82333; }

        /* STATS SECTION */
        .stats { display: flex; gap: 15px; margin-bottom: 20px; } 
        .stat { 
            padding: 20px; 
            flex: 1; 
            background: #eef3ff; /* Light background for stats */
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05); 
            text-align: center;
        } 
        .stat h3 { margin: 0 0 5px; font-size: 1em; font-weight: normal; color: #555; } 
        .stat h1 { margin: 0; font-size: 2.2em; color: #7F7BFF; } 
        .stat.pending h1 { color: #dc3545; }
        
        /* Filter Section */
        .filter { 
            margin-bottom: 20px; 
            padding: 15px; 
            background: #ffffff; 
            border-radius: 8px; 
            box-shadow: 0 2px 6px rgba(0,0,0,0.1); 
            border: 1px solid #d4d4d4;
        } 
        .filter form {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        select {
            padding: 10px 12px;
            border: 1px solid #d4d4d4;
            border-radius: 6px;
            font-size: 0.95em;
            background: #eef3ff;
        }
        button { 
            padding: 10px 15px; 
            background: #28a745; 
            color: white; 
            border: none; 
            cursor: pointer; 
            border-radius: 6px;
            font-size: 1em;
            transition: background 0.3s;
        }
        button:hover { background: #1f7a34; }

        /* Chart & Table Flex Containers */
        .flex { display: flex; gap: 20px; flex-wrap: wrap; margin-top: 15px; } 

        .chart-container, .table-container { 
            background: #ffffff; 
            border-radius: 8px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); 
            padding: 20px; 
        } 
        .chart-container { 
            flex: 1 1 350px; 
            max-height: 480px; 
        }
        .table-container { 
            flex: 2 1 600px; 
            overflow-x: auto; 
        }
        
        /* Chart specific text */
        .chart-container h3 { font-size: 1.2em; margin-top: 0; color: #222; }
        .chart-container p { font-size: 1em !important; margin-top: 5px; font-weight: bold; } 
        
        /* Table adjustments */
        table { width: 100%; border-collapse: collapse; margin-top: 15px; min-width: 700px; } 
        th, td { padding: 10px 8px; font-size: 0.9em; border: 1px solid #ddd; } 
        th { background: #7F7BFF; color: white; text-align: left; }
        #search { margin-bottom: 10px; padding: 10px; width: 250px; font-size: 0.9em; border: 1px solid #d4d4d4; border-radius: 6px;} 
        
        /* Column Widths (Ensuring no scroll) */
        #recordsTable th:nth-child(1), #recordsTable td:nth-child(1) { width: 5%; } 
        #recordsTable th:nth-child(2), #recordsTable td:nth-child(2) { width: 15%; } 
        #recordsTable th:nth-child(3), #recordsTable td:nth-child(3) { width: 20%; } 
        #recordsTable th:nth-child(4), #recordsTable td:nth-child(4) { width: 18%; } 
        #recordsTable th:nth-child(5), #recordsTable td:nth-child(5) { width: 21%; } 
        #recordsTable th:nth-child(6), #recordsTable td:nth-child(6) { width: 21%; } 
        
        /* Assignment cell alignment */
        .download-btn { 
            padding: 6px 10px; 
            background: #28a745; 
            color: white; 
            text-decoration:none; 
            border-radius: 4px; 
            font-size: 0.85em; 
            margin-top: 5px; 
            display: block; 
            width: fit-content; 
            margin-left: auto; 
            margin-right: auto;
        }
        .download-btn:hover { background: #1f7a34; }
        .assignment-cell { 
            padding: 10px 5px; 
            line-height: 1.4;
            font-size: 0.9em; 
            text-align: center; 
            vertical-align: middle;
        }
        .assignment-cell span {
            display: block;
            margin-bottom: 5px;
        }

        /* Media Query for smaller devices (e.g., phones) */
        @media (max-width: 768px) {
            .stats { flex-direction: column; }
            .flex { flex-direction: column; }
            .filter form { flex-direction: column; align-items: stretch; gap: 10px; }
            .filter select, .filter button { margin-right: 0; }
            .chart-container, .table-container { 
                max-height: none;
                flex: 1 1 100%; 
            }
        }
    </style>
</head>
<body>

<div class="main-content">
    <div class="header">
        <h2>🏫 HOD Dashboard - Welcome <?= htmlspecialchars($hod_name) ?></h2>
        <a href="logout.php" class="logout">Logout</a>
    </div>

    <div class="stats">
        <div class="stat">
            <h3>Total Students</h3>
            <h1><?= $total_students ?></h1>
        </div>
        <div class="stat">
            <h3>Submitted</h3>
            <h1><?= $submitted_students ?></h1>
        </div>
        <div class="stat pending">
            <h3>Pending</h3>
            <h1><?= $pending_students ?></h1>
        </div>
    </div>

    <div class="filter">
        <form method="GET" id="filterForm">
            <label>Semester:</label>
            <select name="semester">
                <option value="">All</option>
                <?php if ($semesters) {
                    $semesters->data_seek(0);
                    while ($row = $semesters->fetch_assoc()) {
                        $sel = ($selected_sem == $row['sem']) ? 'selected' : '';
                        echo "<option value=\"{$row['sem']}\" $sel>{$row['sem']}</option>";
                    }
                } ?>
            </select>
            <label>Subject:</label>
            <select name="subject">
                <option value="">All</option>
                <?php if ($subjects) {
                    $subjects->data_seek(0);
                    while ($row = $subjects->fetch_assoc()) {
                        $sel = ($selected_subject == $row['name']) ? 'selected' : '';
                        $name = htmlspecialchars($row['name']);
                        echo "<option value=\"$name\" $sel>$name</option>";
                    }
                } ?>
            </select>
            <label>Type:</label>
            <select name="assignment_type">
                <option value="">All</option>
                <?php if ($types) {
                    $types->data_seek(0);
                    while ($row = $types->fetch_assoc()) {
                        $sel = ($selected_type == $row['assignment_type']) ? 'selected' : '';
                        $type = htmlspecialchars($row['assignment_type']);
                        echo "<option value=\"$type\" $sel>$type</option>";
                    }
                } ?>
            </select>
            <button type="submit" id="applyBtn">Apply</button>
        </form>
    </div>

    <div class="flex">
        <div class="chart-container">
            <h3>📊 Assignment Submission</h3>
            <?php if (count($type_count) > 0): ?> 
            <canvas id="pieChart" style="max-height: 350px;"></canvas>
            <p style="margin-top: 5px; font-weight: bold; font-size: 1em;">Total Submissions: <?= array_sum($type_count) ?></p>
            
            <?php else: ?>
            <p style="color: #777;">No assignment data found based on the current selection.</p>
            <?php endif; ?>
        </div>

        <div class="table-container">
            <h3>📄 Assignment Records</h3>
            <?php if (count($grouped_records) > 0): ?>
                <input type="text" id="search" placeholder="Search USN, Name, Subject">
                <table id="recordsTable">
                    <thead>
                        <tr>
                            <th>S.No</th>
                            <th>USN</th>
                            <th>Name</th>
                            <th>Subject</th>
                            <th class="assignment-cell">Assignment 1</th>
                            <th class="assignment-cell">Assignment 2</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $i = 1;
                        foreach ($grouped_records as $record): 
                            ?>
                            <tr>
                                <td><?= $i++ ?></td>
                                <td><?= htmlspecialchars($record['usn']) ?></td>
                                <td><?= htmlspecialchars($record['student_name']) ?></td>
                                <td><?= htmlspecialchars($record['subject']) ?></td>
                                <td class="assignment-cell">
                                    <?php
                                    // Logic for Assignment 1
                                    if (isset($record['assignments'][1])) {
                                        $a1 = $record['assignments'][1];
                                        echo "<span>" . htmlspecialchars($a1['type']) . "</span>";
                                        if (!empty($a1['file'])) {
                                            $file = urlencode($a1['file']);
                                            echo "<a href='download.php?file=$file' target='_blank' class='download-btn'>View</a>";
                                        } else {
                                            echo "<span style='color:#f0ad4e;'>File Missing</span>";
                                        }
                                    } else {
                                        echo "<span style='color:#dc3545;'>Pending</span>";
                                    }
                                    ?>
                                </td>
                                <td class="assignment-cell">
                                    <?php
                                    // Logic for Assignment 2
                                    if (isset($record['assignments'][2])) {
                                        $a2 = $record['assignments'][2];
                                        echo "<span>" . htmlspecialchars($a2['type']) . "</span>";
                                        if (!empty($a2['file'])) {
                                            $file = urlencode($a2['file']);
                                            echo "<a href='download.php?file=$file' target='_blank' class='download-btn'>View</a>";
                                        } else {
                                            echo "<span style='color:#f0ad4e;'>File Missing</span>";
                                        }
                                    } else {
                                        echo "<span style='color:#dc3545;'>Pending</span>";
                                    }
                                    ?>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            <?php else: ?>
                <p style="color:#777;'>No assignment records found based on the current selection.</p>
            <?php endif; ?>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
<script>
<?php if (count($type_count) > 0): ?> 
// --- Chart JS Initialization ---
const ctx = document.getElementById('pieChart').getContext('2d');
const data = {
    labels: <?= json_encode(array_keys($type_count)) ?>,
    datasets: [{
        data: <?= json_encode(array_values($type_count)) ?>,
        backgroundColor: ['#007bff','#28a745','#ffc107','#dc3545','#17a2b8','#6f42c1','#fd7e14'],
    }]
};
const total = data.datasets[0].data.reduce((a,b) => a+b, 0);

new Chart(ctx, {
    type: 'pie',
    data: data,
    options: {
        plugins: {
            datalabels: {
                color: '#fff',
                formatter: function(value) {
                    let percent = (value / total * 100).toFixed(1);
                    return percent + '%';
                },
                font: {
                    weight: 'bold',
                    size: 16 // INCREASED: Larger font size for percentages
                }
            },
            legend: {
                position: 'bottom',
                labels: {
                    font: {
                        size: 14 // INCREASED: Larger font size for legend labels
                    }
                }
            }
        },
        aspectRatio: 1, 
        responsive: true,
        maintainAspectRatio: true
    },
    plugins: [ChartDataLabels]
});
<?php endif; ?>

// --- Keyboard Submission Logic for Enter Key ---
const filterForm = document.getElementById('filterForm');
const filterElements = filterForm.querySelectorAll('select');
const applyButton = document.getElementById('applyBtn');

// This logic ensures Enter submits the form when a filter is active
filterElements.forEach(selectElement => {
    selectElement.addEventListener('keydown', function(event) {
        if (event.keyCode === 13) {
            event.preventDefault(); 
            filterForm.submit();
        }
    });
});

// --- Simple search filter for the table ---
const searchInput = document.getElementById('search');
if (searchInput) {
    searchInput.addEventListener('input', function () {
        const val = this.value.toLowerCase();
        const rows = document.querySelectorAll('#recordsTable tbody tr');
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(val) ? '' : 'none';
        });
    });
}
</script>
</body>
</html>