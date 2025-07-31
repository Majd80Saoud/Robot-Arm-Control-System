# Robot-Arm-Control-System

The “Robot Arm Control System” is an integrated smart project designed to control a 4-motor robotic arm using a simple and interactive interface built with Flutter. It features full support for saving and retrieving arm positions via a MySQL database and a PHP backend.

### Project Goals:
 • Control each of the arm’s servo motors via sliders.
 • Save the current pose (set of motor angles) into the database along with a status flag.
 • Display all saved poses and allow the user to activate (run) them.
 • Update the status of poses (e.g., mark as completed or inactive).
 • Allow future expansion for AI integration or remote operation.

### Tech Stack:
 • Flutter: For building the user interface and handling motor controls.
 • PHP (Backend): To manage communication between the app and the database.
 • MySQL: For storing saved poses and their status.
 • XAMPP: To run Apache and MySQL servers locally on the same device.
