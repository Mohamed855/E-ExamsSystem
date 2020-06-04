<?php
	include 'singleton.php';
	$action=$_POST["action"];
	/*$servername="localhost";
	$username="root";
	$password="";
	$dbname="E-exam";
	$dsn='mysql:host=localhost;dbname=E-exam';
	try{
		$db=new PDO($dsn,$username,$password);
	}
	catch(PDOException $e){
		echo "failed"." ".$e->getMessage();
	}*/
	$a=array();
	$a1=array();
	if($action=="getProfessordata"){
		$f = new professoractions;
		$f->getProfessordData();
		
		//getProfessordData();
	}else if ($action=="check_your_email_and_password"){
		$email=$_POST['email'];
		$f = new professoractions;
		$f->checkYourEmailAndPassword($email);
		
		//checkYourEmailAndPassword($email);
	}else if ($action=="get_the_subject"){
		$Professor=$_POST['Professor'];
		$f = new professoractions;
		$f->getTheSubject($Professor);
		
		//getTheSubject($Professor);
	}else if ($action=="add_chapter"){
		$subjectname=$_POST['subjectname'];
		$chaptername=$_POST['chaptername'];
		$f = new professoractions;
		$f->addChapter($subjectname,$chaptername);
		
		//addChapter($subjectname,$chaptername);
	}else if ($action=="getchapterdata"){
		$f = new professoractions;
		$f->getChapterData();
		
		//getChapterData();
	}else if ($action=="remove_chapter"){
		$subjectname=$_POST['subjectname'];
		$id=$_POST['id'];
		$f = new professoractions;
		$f->removeChapter($subjectname,$id);
		
		//removeChapter($subjectname,$id);
	}else if ($action=="add_question_true_and_false_tosqlite"){
		$question=$_POST['question'];
		$subject=$_POST['subject'];
		$numberofchapter=$_POST['numberofchapter'];
		$correctanswer=$_POST['correctanswer'];
		$bank=$_POST['bank'];
		$f = new professoractions;
		$f->addQuestionTrueAndFalseToDatabase($question,$subject,$numberofchapter,$correctanswer,$bank);
		
		//addQuestionTrueAndFalseToDatabase($question,$subject,$numberofchapter,$correctanswer,$bank);
	}else if ($action=="add_question_mcq_tosqlite"){
		$question=$_POST['question'];
		$subject=$_POST['subject'];
		$numberofchapter=$_POST['numberofchapter'];
		$level=$_POST['level'];
		$answer1=$_POST['answer1'];
		$answer2=$_POST['answer2'];
		$answer3=$_POST['answer3'];
		$answer4=$_POST['answer4'];
		$correctanswer=$_POST['correctanswer'];
		$bank=$_POST['bank'];
		$f = new professoractions;
		$f->addQuestionMcqToDatabase($question,$subject,$numberofchapter,$level,$answer1,$answer2,$answer3,$answer4,$correctanswer,$bank);

		//addQuestionMcqToDatabase($question,$subject,$numberofchapter,$level,$answer1,$answer2,$answer3,$answer4,$correctanswer,$bank);
	}else if ($action=="get_the_queationtrue_and_false"){
		$f = new professoractions;
		$f->getTheQueationTrueAndFalse();
		//getTheQueationTrueAndFalse();
	}else if ($action=="get_the_queation_mcq"){
		$f = new professoractions;
		$f->getTheQueationMCQ();
		
		//getTheQueationMCQ();
	}else if ($action=="remove_mcq_question"){
		$id=$_POST['id'];
		$f = new professoractions;
		$f->removeMCQQuestion($id);
		
		//removeMCQQuestion($id);
	}else if ($action=="queastion_true_and_false"){
		$id=$_POST['id'];
		$f = new professoractions;
		$f->queastionTrueAndFalse($id);
		
		//queastionTrueAndFalse($id);
	}else if ($action=="add_detailsexam"){
		$subject=$_POST['subject'];
		$when=$_POST['when'];
		$time=$_POST['time'];
		$data=$_POST['data'];
		$f = new professoractions;
		$f->addDetailsExam($subject,$when,$time,$data);
		
		//addDetailsExam($subject,$when,$time,$data);
		
	}else if ($action=="addchaptertoexam"){
		$examid=$_POST['examid'];
		$chapter=$_POST['chapter'];
		$level=$_POST['level'];
		$type=$_POST['type'];
		$count=$_POST['count'];
		$f = new professoractions;
		$f->addChapterToExam($examid,$chapter,$level,$type,$count);
		
		//addChapterToExam($examid,$chapter,$level,$type,$count);

	}else if ($action=="counterMCQ"){
		$subject=$_POST['subject'];
		$f = new professoractions;
		$f->counterMCQ($subject);
		
		//counterMCQ($subject);
	}else if ($action=="counterTrueAndFalse"){
		$subject=$_POST['subject'];
		$f = new professoractions;
		$f->counterTrueAndFalse($subject);
		
		//counterTrueAndFalse($subject);
	}
	class professoractions{
	//add the details about the chapters will be in exam to database
	function addChapterToExam($idexam,$chapter,$level,$type,$count) {
		$db= Connection::getInstance();
    	
  		  global $db;
		$state=$db->prepare("INSERT INTO examchapter(examid,chapter,level,type,count)VALUES('$idexam','$chapter','$level','$type','$count')");
		$state->execute();
		
  }
  //add the details about exam to database
	function addDetailsExam($subject,$when,$time,$data){
		global $db;
		$db= Connection::getInstance();
    	
		$state=$db->prepare("INSERT INTO examdetails(subject,whenstart,time)VALUES('$subject','$when','$time')");
		$state->execute();
		$add = $db->lastInsertId();
		echo $add;
	/*	$a=json_decode($data);
		$a1=json_encode($data);
		$q=1;
		//echo json_decode($a[0])."\n";
		//echo $a1."\n";
		for($i=0;$i<sizeof($data);$i++){
			if($data[$i]['countOfTrueAndFalse']==null||$data[$i]['countOfTrueAndFalse']==0){}else{
				addchaptertoexam("$add", "$q", "null", "trueandfalse", $data[$i]['countOfTrueAndFalse']);
			}
			if($data[$i]['countOfMCALevelA']==null||$data[$i]['countOfMCALevelA']==0){}else{
				//addchaptertoexam("$add", "$q", "null", "trueandfalse", $a[$i]['countOfMCALevelA']);
				addchaptertoexam("$add", "$q", "A", "mcq",$data[$i]['countOfMCALevelA']);
			}
			if($data[$i]['countOfMCALevelB']==null||$data[$i]['countOfMCALevelB']==0){}else{
				//addchaptertoexam("$add", "$q", "null", "trueandfalse", $a[$i]['countOfMCALevelA']);
				addchaptertoexam("$add", "$q", "B", "mcq",$data[$i]['countOfMCALevelB']);
			}
			if($data[$i]['countOfMCALevelC']==null||$data[$i]['countOfMCALevelC']==0){}else{
				//addchaptertoexam("$add", "$q", "null", "trueandfalse", $a[$i]['countOfMCALevelA']);
				addchaptertoexam("$add", "$q", "C", "mcq",$data[$i]['countOfMCALevelC']);
			}
			$q++;
		}
	 	  $data1=array_map($data);
	 	  //	echo $data[];
//	 	  	echo $data1[0];
	 	echo $data1["chapter1trueandfalse"];
	 	if($data["chapter1trueandfalse"]!=null){
	 		addchaptertoexam("$add", "1", "null", "trueandfalse", $data["chapter1trueandfalse"]);
	 	}if($data["chapter2trueandfalse"]!=null){
	 		addchaptertoexam("$add", "2", "null", "trueandfalse", $data["chapter2trueandfalse"]);
	 	}if($data["chapter3trueandfalse"]!=null){
	 		addchaptertoexam("$add", "3", "null", "trueandfalse", $data["chapter3trueandfalse"]);
	 	}if($data["chapter4trueandfalse"]!=null){
	 		addchaptertoexam("$add", "4", "null", "trueandfalse", $data["chapter4trueandfalse"]);
	 	}if($data["chapter5trueandfalse"]!=null){
	 		addchaptertoexam("$add", "5", "null", "trueandfalse", $data["chapter5trueandfalse"]);
	 	}if($data["chapter1mcqa"]!=null){
	 		addchaptertoexam("$add", "1", "A", "mcq",$data["chapter1mcqa"]);
	 	}if($data["chapter1mcqb"]!=null){
	 		addchaptertoexam("$add", "1", "B", "mcq",$data["chapter1mcqb"]);
	 	}if($data["chapter1mcqc"]!=null){
	 		addchaptertoexam("$add", "1", "C", "mcq",$data["chapter1mcqc"]);
	 	}
	 	if($data["chapter2mcqa"]!=null){
	 		addchaptertoexam("$add", "2", "A", "mcq",$data["chapter2mcqa"]);
	 	}if($data["chapter2mcqb"]!=null){
	 		addchaptertoexam("$add", "2", "B", "mcq",$data["chapter2mcqb"]);
	 	}if($data["chapter2mcqc"]!=null){
	 		addchaptertoexam("$add", "2", "C", "mcq",$data["chapter2mcqc"]);
	 	}
	 	if($data["chapter3mcqa"]!=null){
	 		addchaptertoexam("$add", "3", "A", "mcq",$data["chapter3mcqa"]);
	 	}if($data["chapter3mcqb"]!=null){
	 		addchaptertoexam("$add", "3", "B", "mcq",$data["chapter3mcqb"]);
	 	}if($data["chapter3mcqc"]!=null){
	 		addchaptertoexam("$add", "3", "C", "mcq",$data["chapter3mcqc"]);
	 	}

	 	if($data["chapter4mcqa"]!=null){
	 		addchaptertoexam("$add", "4", "A", "mcq",$data["chapter4mcqa"]);
	 	}if($data["chapter4mcqb"]!=null){
	 		addchaptertoexam("$add", "4", "B", "mcq",$data["chapter4mcqb"]);
	 	}if($data["chapter4mcqc"]!=null){
	 		addchaptertoexam("$add", "4", "C", "mcq",$data["chapter4mcqc"]);
	 	}

	 	if($data["chapter5mcqa"]!=null){
	 		addchaptertoexam("$add", "5", "A", "mcq", $data["chapter5mcqa"]);
	 	}if($data["chapter5mcqb"]!=null){
	 		addchaptertoexam("$add", "5", "B", "mcq", $data["chapter5mcqb"]);
	 	}if($data["chapter5mcqc"]!=null){
	 		addchaptertoexam("$add", "5", "C", "mcq", $data["chapter5mcqc"]);
	 	}*/

	}
	//get the counter of about the questions in database in level A, B or C 
function counterMCQ($subject){
		global $db;
		$db= Connection::getInstance();
    	
		foreach ($db->query("SELECT counter FROM Subject WHERE Name='$subject';") as $result){
   				$a[]=$result;
		}
		$counter= $a[0]['counter'];
		for ($i=1;$i<=$counter;$i++){
			foreach ($db->query("SELECT SUM( numberofchapter=$i AND subject='$subject' AND level='A' )as levelA,SUM( numberofchapter=$i AND subject='$subject' AND level='B' )as levelB,SUM( numberofchapter=$i AND subject='$subject' AND level='C' )as levelC FROM queastion_mcq") as $result){
					$countMCQ[]=$result;
			}
		}
		echo json_encode($countMCQ);
	}
	//get the counter of the true and false questions
	function counterTrueAndFalse($subject){
		global $db;
		$db= Connection::getInstance();
    	
		foreach ($db->query("SELECT counter FROM Subject WHERE Name='$subject';") as $result){
   				$a[]=$result;
		}
		$counter= $a[0]['counter'];
		for ($i=1;$i<=$counter;$i++){
			foreach ($db->query("SELECT COUNT(*)as counter FROM queastion_true_and_false WHERE numberofchapter=$i AND subject='$subject';") as $result){
   					$countTrueAndFalse[]=$result;
			}
		}
		echo json_encode($countTrueAndFalse);
		//echo"wwwwwwwwwwww";
	}
	//for delete the true and false question
	function queastionTrueAndFalse($id){
		global $db;
		$db= Connection::getInstance();
    	
		$sql="DELETE FROM queastion_true_and_false WHERE ID='$id'";
		$db->query($sql);
	}
	//for delete the MCQ question
	function removeMCQQuestion($id){
		global $db;
		$db= Connection::getInstance();
    	
		$sql="DELETE FROM queastion_mcq WHERE ID='$id'";
		$db->query($sql);
	}
	//get the mcq questions
	function getTheQueationMCQ(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM queastion_mcq ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	//get the true and false questions
	function getTheQueationTrueAndFalse(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM queastion_true_and_false ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	//add the mcq question
	function addQuestionMcqToDatabase($question,$subject,$numberofchapter,$level,$answer1,$answer2,$answer3,$answer4,$correctanswer,$bank){
		global $db;
		$db= Connection::getInstance();
    	
			foreach ($db->query("SELECT COUNT(*) FROM Chapter WHERE subjectname='$subjectname';") as $result){
   			$a[]=$result;
		}
		json_encode($a);
		$s=$a[0]['COUNT(*)'];
		$state=$db->prepare("INSERT INTO queastion_mcq(ID,Question,subject,numberofchapter,level,answer1,answer2,answer3,answer4,correctanswer,bank)VALUES($s,'$question','$subject','$numberofchapter','$level','$answer1','$answer2','$answer3','$answer4','$correctanswer','$bank')");
			$state->execute();
	}
	// add the true and false question
	function addQuestionTrueAndFalseToDatabase($question,$subject,$numberofchapter,$correctanswer,$bank){
		$db= Connection::getInstance();
    	
		global $db;
			foreach ($db->query("SELECT COUNT(*) FROM Chapter WHERE subjectname='$subjectname';") as $result){
   			$a[]=$result;
		}
		json_encode($a);
		$s=$a[0]['COUNT(*)'];

		$state=$db->prepare("INSERT INTO queastion_true_and_false(ID,Question,subject,numberofchapter,correctanswer,bank)VALUES($s,'$question','$subject','$numberofchapter','$correctanswer','$bank')");
			$state->execute();
			echo($numberofchapter);
		
	}
	//to remove the chapter
	function removeChapter($subjectname,$id){
		$db= Connection::getInstance();
    	
		try{
		global $db;
		$sql="DELETE FROM Chapter WHERE ID='$id'";
		$db->query($sql);
			
		foreach ($db->query("SELECT COUNT(*) FROM Chapter WHERE subjectname='$subjectname';") as $result){
   			$a[]=$result;
		}
		json_encode($a);
		$s=$a[0]['COUNT(*)'];
		$db->query("UPDATE Subject SET counter=$s WHERE Name='$subjectname'");
		echo "done";
	}
		catch(PDOException $e){
		echo "failed"." ".$e->getMessage();
		}		
	}
	//get the data about chapter
	function getChapterData(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM Chapter ;") as $result){
   			$a[]=$result;
		}

		echo json_encode($a);
	}
	//add new chapter
	function addChapter($subjectname,$chaptername){
		global $db;
		$db= Connection::getInstance();
    	
		try{
			foreach ($db->query("SELECT * FROM Chapter WHERE  subjectname='$chaptername';") as $result){
   		$a[]=$result;
		}
		for($i=0;$i<count($a);$i++){
			if($a[$i]['chaptername']==$subjectname){
				echo"name used";
			return "used";
			}
			
		}
		
		$state=$db->prepare("INSERT INTO Chapter(subjectname,chaptername)VALUES('$chaptername','$subjectname')");
			$state->execute();

		foreach ($db->query("SELECT COUNT(*) FROM Chapter WHERE subjectname='$chaptername';") as $result){
   			$a[]=$result;
		}
		json_encode($a);
		$s=$a[0]['COUNT(*)'];
		echo $s;
		$db->query("UPDATE Subject SET counter=$s WHERE Name='$chaptername'");
		echo "done";
	}
		catch(PDOException $e){
		echo "failed"." ".$e->getMessage();
		}		
	}
	//get the subject based on the name of professor
	function getTheSubject($Professor){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM Subject WHERE professor='$Professor'  ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	//get the professor data
	function getProfessordData(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM Professor ;") as $result){
   			$a[]=$result;
		}

		echo json_encode($a);
	}
	//when login get the all data when the email is equal the email you enter
	function checkYourEmailAndPassword($email){
    	//global $db;
    	$db= Connection::getInstance();
    	
    	foreach ($db->query("SELECT * FROM Professor WHERE Email='$email'") as $result) {
    		$a[]=$result;
		}
		echo json_encode($a);
	}
 }
?>