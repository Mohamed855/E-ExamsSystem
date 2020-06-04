# E-exam

## Team members
  1. moataz mohamed saad  2.Mina Morkos Ishaq 3.Mohammed abd al majeed

## Problem description

* make professor can create exam any time and student will take the exam in the spasific time the professor selected it 

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
## Project scope

* our mobile application provides a lot of features helping professors to create a lot of  exams ,and he can choose the chapters and students will take the exam

* professor can add a chapter , can question any time and can create an exam any time ,and he can choose the chapters will be in it ,and the count of questions can be in the exam  

* admin can add department and subject 
 
-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

## Getting Started

1.copy app folder and past it in htdocs folder in XAMPP folder.

2.create a database and call it "E-exam" and import file called"E-exam.sql" which is in folder called database .

<img src="img/readme/1.png" width="700" height="400">
3.make sure "apache web server" and "mySQL Database" in XAMPP are working

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

## Blog Application

### our app split into three parts (Admin , Professors , Student) (Stable)

    - Before explain anything we will be shown how to Login the app as (Admin , professor , student)
    - After importing the database you will find nationl ID for student and email for admin and professor and password for each of them 

<img width="250" alt="portfolio_view" src="img/readme/chooseBetweenAdminProfessorStudent.jpg">|<img width="250" alt="portfolio_view" src="img/readme/loginAdmin.jpg">|<img width="250" alt="portfolio_view" src="img/readme/loginProfessor.jpg">|<img width="250" alt="portfolio_view" src="img/readme/loginStudent.jpg">

### signup (Admin , Professors , Student) (Stable)
    -Admin and Professors send a request to activate their account
    -student create account
<img width="250" alt="portfolio_view" src="img/readme/signupAdmin.jpg">|<img width="250" alt="portfolio_view" src="img/readme/signupProfessor.jpg">|<img width="250" alt="portfolio_view" src="img/readme/sginupStudent.jpg">

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

# 1 - Authorities of the admin part (Stable)
    -After login as admin
    -admin see the requests of admins and Professors to activate their accounts
<img width="250" alt="portfolio_view" src="img/readme/signupRequests.jpg">

    -the menu of the admin
<img width="250" alt="portfolio_view" src="img/readme/adminMenu.jpg">

  -------------------------------------------------------------------------------------------------

  -------------------------------------------------------------------------------------------------

## Adds and edit Subject (Stable)

### add Subject screen contain (Stable)

1-add subject name.

2-choose the subject will be in semester one or semester two.

3-choose the subject will be for which level.

4-choose the subject will be for which department.

5-choose the professor will teach it

<img width="250" alt="portfolio_view" src="img/readme/addSubject.jpg">

### show and edit Subject (Stable)

1 - show all subjects

2 - admin can delete or edit a subject

<img width="250" alt="portfolio_view" src="img/readme/getSubject.jpg">|<img width="250" alt="portfolio_view" src="img/readme/editSubject.jpg">

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

## Adds, delete and edit department (Stable)

1-add department name.

2-choose  when the students can join the department .

5-choose the professor will be the manager of that department.

<img width="250" alt="portfolio_view" src="img/readme/addDepartment.jpg">

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

# 2 - Authorities of the Professors part (Stable)

    -After login as a Professors

<img width="250" alt="portfolio_view" src="img/readme/professorMenu.jpg">|<img width="250" alt="portfolio_view" src="img/readme/professorMain.jpg">


-------------------------------------------------------------------------------------------------

  -------------------------------------------------------------------------------------------------

## Adds, delete  Chapter (Stable)

### add Chapter screen contain (Stable)

1-add subject name.

2-choose that chapter for which subject.

<img width="250" alt="portfolio_view" src="img/readme/addChapter.jpg">

### show and delete Chapter (Stable)

1 - show all subjects

2 - Professor can delete a Chapter

<img width="250" alt="portfolio_view" src="img/readme/getChapter.jpg">

  -------------------------------------------------------------------------------------------------

## Adds, delete  Question (Stable)

### add Question screen contain (Stable)

1-add Question name.

2-choose that subject for this Question.

3-choose the number of chapter

4- choose if the Question is MCQ or true&false

if the Question is mcq 

5-choose the level of Question

6-add the four answers of the Question

7-choose the correct answer 

8-click on the checkbox to save it in the student bank

if the Question is true&false choose the correct answer and click on the checkbox to save it in the student bank

<img width="250" alt="portfolio_view" src="img/readme/mcqAddQuestion.jpg">|<img width="250" alt="portfolio_view" src="img/readme/trueAndFalseAddQuestion.jpg">


### show and delete Question (Stable)

1 - show all subjects

2 - Professor can delete a Question

<img width="250" alt="portfolio_view" src="img/readme/professorShowQuestion.jpg">

-------------------------------------------------------------------------------------------------

## add Exam screen contain (Stable)

1-choose that subject for this Question.

2-enter the time on exam.

3-enter howlong of exam

4- enter the count of chapter will be in the exam

<img width="250" alt="portfolio_view" src="img/readme/addExam.jpg">

5-enter the count of true&false Question 

6-enter the count of MCQ Question

<img width="250" alt="portfolio_view" src="img/readme/addChapter1.jpg">


-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------

# 3 - Authorities of the Students part (Stable)

    -After login as a Student

<img width="250" alt="portfolio_view" src="img/readme/studentMenu.jpg">|
<img width="250" alt="portfolio_view" src="img/readme/studentMain.jpg">


-------------------------------------------------------------------------------------------------

## Choose Exam screen contain (Stable)

    -choose the subject based on the day of the exam.
<img width="250" alt="portfolio_view" src="img/readme/chooseExam.jpg">

    -the exam screen and get the result when finish the questions or the time is up
    

<img width="250" alt="portfolio_view" src="img/readme/chooseExam.jpg">|
<img width="250" alt="portfolio_view" src="img/readme/examResult.jpg">

-------------------------------------------------------------------------------------------------

  -------------------------------------------------------------------------------------------------

## Show Questions Bank (Stable)
   
    -choose the subject and the type of Questions

<img width="250" alt="portfolio_view" src="img/readme/bankQuestion.jpg">

