Flutter Login Tutorial using Bloc

Authentication Repository
    เป็นการสร้าง Package ไว้สำหรับจัดการเกี่ยวกับการ Authentication โดยสร้าง package ของมันไว้ใน directory
    จากนั้นสร้าง class AuthenticationRepository โดยมันจะ exposes Stream ของ AuthenticationStatus อัพเดตเพื่อที่จะใช้สำหรับแจ้งตัวApp เมื่อ user เข้าใช้หรือออก
 
User Repository
    สร้าง package ของมันไว้ใน directory เหมือนกันกับ Authen Repo แต่ User Repo จะทำการดูแลในส่วนของ user domain และ การส่ง API ตอบสนองกับ user ปัจจุบัน


Authentication Bloc
    Auth Bloc จะทำการรับผิดชอบในการตอบสนองเพื่อที่จะเปลี่ยนแปลง auth state และ ส่ง state 
  -authentication_event
        เป็นตัวกำหนด(รับ)การกระทำต่างๆภายใน Bloc
  -authentication_state
        เป็นตัวกำหนด state ต่างๆภานใน Bloc
  -authentication_bloc
        เป็นตัวจัดการ auth state ของ App เพื่อใช้กำหนดสิ่งต่างๆ

App
    จะถูกแบ่งเป็น 2 ส่วน คือ App กับ AppView App จะลำผิดชอบในการ creating/providing(จัดเตรียม) AuthBloc ซึ่ง AppView จะเอามาใช้

Splash
    เป็น feature ไว้ใช้สำหรับมุมมองการแสดงผลที่ถูกต้องเมื่อเปิด App ในขณะที่ app กำหนดว่าผู้ใช้นั้นได้รับการ Authenticated

Login
    - Login Models
        ทำการเรียกใข้ package:formz เพื่อ reuse สำหรับ username และ password
    -Login Bloc 
        เป้นตัวจัดการ state ใน LoginForm และค่อยดูแลการ Validate ของ username และ password input ฃ
    -login_event
        กำหนด event ภายใน bloc login
    -login_state
        กำหนด state ในการกรอก form ของ username และ password ใน state
    -login_bloc
        เป็นตัวจัดการตอยสนองกับผู้ใช้ใน LoginForm และจัดการการ Validate และ submission ของ form
    -Login Page
        จะแสดง Route รวมถึงการ creat และ povide จากLoginBloc สู่ LoginForm
    -Login Form
        จะจัดการแจ้งเตือน LoginBloc ของ user event และตอบสนองกับการเปลี่ยน state โดยใช้ BlocBuilder และ BlocListener