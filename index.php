<?php session_start(); ?>
<!DOCTYPE html>
<html>
<head>
    <title>Assignment Tracker - Login</title>

    <!-- Eye Icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #7F7BFF, #E26D9A);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 420px;
            background: #ffffffd9;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0px 10px 25px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 28px;
            font-weight: bold;
            color: #222;
        }

        .input-box {
            position: relative;
            width: 100%;
            margin-bottom: 20px;
        }

        .input-box input,
        .input-box select {
            width: 100%;
            padding: 12px 14px;
            padding-right: 45px;  /* space for eye icon */
            border: 1px solid #d4d4d4;
            border-radius: 6px;
            font-size: 16px;
            background: #eef3ff;
            box-sizing: border-box;
        }

        .input-box input:focus,
        .input-box select:focus {
            border-color: #7F7BFF;
            outline: none;
        }

        /* Eye icon */
        #toggleEye {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #444;
            font-size: 20px;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #28a745;
            color: white;
            font-size: 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 8px;
        }

        button:hover {
            background: #1f7a34;
        }

    </style>
</head>
<body>

    <div class="container">
        <h2>Login</h2>

        <form method="POST" action="login_process.php">

            <!-- Username -->
            <div class="input-box">
                <input type="text" name="username" placeholder="Enter Username" required>
            </div>

            <!-- Password -->
            <div class="input-box">
                <input type="password" id="password" name="password" placeholder="Enter Password" required>
                <i class="fa-solid fa-eye" id="toggleEye" onclick="togglePassword()"></i>
            </div>

            <!-- Role -->
            <div class="input-box">
                <select name="role" required>
                    <option value="">Select Role</option>
                    <option value="student">Student</option>
                    <option value="teacher">Teacher</option>
                    <option value="hod">HOD</option>
                </select>
            </div>

            <button type="submit">Login</button>
        </form>
    </div>

    <script>
        function togglePassword() {
            let pwd = document.getElementById("password");
            let eye = document.getElementById("toggleEye");

            if (pwd.type === "password") {
                pwd.type = "text";
                eye.classList.remove("fa-eye");
                eye.classList.add("fa-eye-slash");
            } else {
                pwd.type = "password";
                eye.classList.remove("fa-eye-slash");
                eye.classList.add("fa-eye");
            }
        }
    </script>

</body>
</html>
