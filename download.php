<?php
// Set error reporting to catch issues, but don't display them on the page
error_reporting(E_ALL); 
ini_set('display_errors', 0); 

$file_input = $_GET['file'] ?? '';

// 1. URL-decode the input path (Crucial for filenames with spaces/special characters)
$decoded_file_input = urldecode($file_input);

// 2. Security: Remove any attempts to navigate outside the project directory (../)
$safe_file_path = str_replace(['../', '..\\', '..'], '', $decoded_file_input);

// 3. Normalize slashes: Replace forward slashes (/) with the correct system separator (\ for Windows)
// This is essential for combining the path parts correctly on your WAMP server.
$normalized_file_path = str_replace('/', DIRECTORY_SEPARATOR, $safe_file_path);

// ⭐ 4. Construct the Absolute Path ⭐
// __DIR__ is the directory where this download.php script is located (e.g., C:\wamp64\www\assignment_tracker\)
$root_dir = __DIR__ . DIRECTORY_SEPARATOR; 

// The final path is ROOT_DIR + the database path (e.g., C:\wamp64\...\uploads\FILENAME.pdf)
$filepath = $root_dir . $normalized_file_path; 

// --- If the file exists, proceed with serving it ---
if (is_file($filepath)) {
    
    // --- File Type Detection ---
    $mime_type = 'application/octet-stream'; 
    $extension = strtolower(pathinfo($filepath, PATHINFO_EXTENSION));

    if (extension_loaded('fileinfo')) {
        $finfo = new finfo(FILEINFO_MIME_TYPE);
        $detected_mime = $finfo->file($filepath);
        if ($detected_mime) {
            $mime_type = $detected_mime;
        }
    } else {
        // Fallback for common file types
        switch ($extension) {
            case 'pdf': $mime_type = 'application/pdf'; break;
            case 'jpg':
            case 'jpeg': $mime_type = 'image/jpeg'; break;
            case 'png': $mime_type = 'image/png'; break;
            default: $mime_type = 'application/octet-stream';
        }
    }
    // --- End File Type Detection ---

    // Set headers for inline viewing (opening in browser)
    header("Content-Type: " . $mime_type); 
    header("Content-Disposition: inline; filename=\"" . basename($filepath) . "\""); 

    // Headers for file size and caching
    header("Content-Length: " . filesize($filepath));
    header("Cache-Control: public, must-revalidate");
    header("Pragma: public");
    
    // Output the file
    if (ob_get_level()) ob_end_clean();
    readfile($filepath);
    exit;

} else {
    // Show the exact path that failed the file_exists check for easy debugging
    http_response_code(404);
    echo "❌ CRITICAL ERROR: File not found! The full path PHP attempted to check was: " . htmlspecialchars($filepath);
    echo "<br>Please verify this path exists and the filename case matches exactly.";
}
?>