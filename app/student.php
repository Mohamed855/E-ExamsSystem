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
	//	echo "connection"."\n";
	}
	catch(PDOException $e){
		echo "failed"." ".$e->getMessage();
	}*/
	$examChapters=array();
	$idOfTrueAndFalse=array();
	$idOfMCQ=array();
	$quection=array();
	$quection1=array();
	$rebet=array();
	$rebet1=array();
	$quection2=array();
	$a=array();
	$subjectforexam=array();
	$countMCQ=array();
	$countTrueAndFalse=array();
	$data=array();
	if ($action=="signupstudent"){
		$nationalid=$_POST['nationalid'];
		$collageid=$_POST['collageid'];
		$name=$_POST['name'];
		$password=$_POST['password'];
		$level=$_POST['level'];
		$department=$_POST['department'];
		$f = new Studentactions;
		$f->signupStudent($nationalid,$collageid,$name,$password,$level,$department);
		
		//signupStudent($nationalid,$collageid,$name,$password,$level,$department);
	}else if ($action=="check_your_email_and_password"){
		$email=$_POST['email'];
		$f = new Studentactions;
		$f->checkYourEmailAndPassword($email);
		
		//checkYourEmailAndPassword($email);
	}else if ($action=="getstudentsubject"){
		$level=$_POST['level'];
		$department=$_POST['department'];
		$f = new Studentactions;
		$f->getStudentSubject($level,$department);
		
		//getStudentSubject($level,$department);
	}else if ($action=="get_the_queationtrue_and_false"){
		$f = new Studentactions;
		$f->getTheQueationTrueAndFalse();
		
		//getTheQueationTrueAndFalse();
	}else if ($action=="get_the_queation_mcq"){
		$f = new Studentactions;
		$f->getTheQueationMcq();
		
		//getTheQueationMcq();
	}else if ($action=="examdetails"){
		$subject1=$_POST['subject'];
		$upd = str_replace('[', '', $subject1);
		$upd1 = str_replace(']', '', $upd);
		$pieces = explode(",", $upd1);
		$f = new Studentactions;
		$f->getExamDetails($pieces);
		
		//getExamDetails($pieces);
	}else if ($action=="getExam"){
		$subject=$_POST['subject'];
   		$id=$_POST['id'];
   		$f = new Studentactions;
		$f->getExam($id,$subject);
		
		//getExam($id,$subject);
	}
	class Studentactions{
		//get the exam questions
		function getExam($id,$subject){
			$db= Connection::getInstance();
    	
			global $db;
			global $quection1;
			global $quection2;
			global $quection;
			global $rebet1;
			global $rebet;
				
			foreach ($db->query("SELECT * FROM examchapter WHERE examid=$id;") as $result){
   			$examChapters[]=$result;
		}
		for($counter=0;$counter<count($examChapters);$counter++){
			global $db;
			$db= Connection::getInstance();
    	
			global $quection1;
			global $quection2;
			global $quection;
			global $rebet1;
			global $rebet;
			if($examChapters[$counter]['type']=="mcq"){
				$chapter= $examChapters[$counter]['chapter'];
				$count=$examChapters[$counter]['count'];
				$level= $examChapters[$counter]['level'];
				foreach ($db->query("SELECT ID FROM queastion_mcq WHERE numberofchapter='$chapter' AND subject='$subject' AND level='$level';") as $result){
   					$idOfMCQ[]=$result;
				}
				for($k=0;$k<$count;$k++){
					$randIndex = array_rand($idOfMCQ);
					$random=$idOfMCQ[$randIndex]['ID'];
					if (in_array($random, $rebet1)) 
  					{$k--;} 
					else
					{array_push($rebet1,$random);
					foreach ($db->query("SELECT * FROM queastion_mcq WHERE ID=$random;") as $result){
   						$quection1[]=$result;
					}}
				}
				unset($random); 
				unset($randIndex); 
				unset($rebet1);
				unset($quection1);
				unset($idOfMCQ); 
			}else {
				$chapter= $examChapters[$counter]['chapter'];
				$count=$examChapters[$counter]['count'];
				foreach ($db->query("SELECT ID FROM queastion_true_and_false WHERE numberofchapter='$chapter' AND subject='$subject';") as $result){
   					$idOfTrueAndFalse[]=$result;
				}
				for($j=0;$j<$count;$j++){
					$randIndex = array_rand($idOfTrueAndFalse);
					$random=$idOfTrueAndFalse[$randIndex]['ID'];
					if (in_array($random, $rebet)) 
  					{$j--;}
					else
					{
						array_push($rebet,$random);
						foreach ($db->query("SELECT * FROM queastion_true_and_false WHERE ID=$random;") as $result){
   						$quection2[]=$result;
						}
					}
				}
				unset($rebet);
				unset($quection2); 
				unset($random); 
				unset($randIndex); 
				unset($idOfTrueAndFalse); 
			}
		}
		global $quection1;
			global $quection2;
			global $quection;
		$quection=array_merge($quection1, $quection2);
		echo json_encode($quection);
	}
	//gte the exam details
	function getExamDetails($subject){
		global $db;
		$db= Connection::getInstance();
    	
		global $data;
		for($i=0;$i<count($subject);$i++){
			//echo $subject[$i]."-";
			if($subject[$i][0]==" "){
				$str = ltrim($subject[$i], ' ');
				foreach ($db->query("SELECT * FROM examdetails WHERE subject='$str';") as $result){
   			$a[]=$result;
			}}else{
				foreach ($db->query("SELECT * FROM examdetails WHERE subject='$subject[$i]';") as $result){
   			$a[]=$result;
			}
			}

			
			
		}
		$d=date("Y-m-d");
		for($j=0;$j<COUNT($a);$j++){
			$rest = substr($a[$j]['whenstart'], 0, 10);
			//echo $a[$j]['whenstart']."pp"."\n";
			//echo $rest."v"."\n";
			if($rest==$d){
				$data[]=$a[$j];
			}
		}
		echo json_encode($data);
	}
	//get The Queation Mcq
	function getTheQueationMcq(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM queastion_mcq WHERE bank='true';") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	// get The Queation True And False
	function getTheQueationTrueAndFalse(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM queastion_true_and_false WHERE bank='true';") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	//get the subjects
	function getStudentSubject($level,$department){
		global $db;
		$db= Connection::getInstance();
    	
   		//foreach ($db->query("SELECT * FROM Subject WHERE level='$level'  ;") as $result){
   		foreach ($db->query("SELECT * FROM Subject WHERE level='$level' AND department='$department' OR level='$level' AND department='general';") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	//check Your Email And Password
	function checkYourEmailAndPassword($email){
    	global $db;
    	$db= Connection::getInstance();
    	
    	foreach ($db->query("SELECT * FROM Student WHERE Collageid='$email'") as $result) {
    		$a[]=$result;
		}
		echo json_encode($a);
	}
	//signup for Student
	function signupStudent($nationalid,$collageid,$name,$password,$level,$department){
		global $db;
		$db= Connection::getInstance();
    	
		foreach ($db->query("SELECT * FROM Student ;") as $result){
   		$a[]=$result;
		}
		for($i=0;$i<count($a);$i++){
			if($a[$i]['Nationalid']==$nationalid){
				echo"Nationalid used";
			return "used";
			}
			if($a[$i]['Collageid']==$collageid){
				echo"collageid used";
			return "used2";
			}
		}
		try{
			$state=$db->prepare("INSERT INTO Student(Nationalid,Collageid,name,password,level,department)VALUES('$nationalid','$collageid','$name','$password','$level','$department')");
			$state->execute();
    		echo "Doned";
    	}catch(PDOException $e){
			echo "failed"." ".$e->getMessage();
		}
	}
	
}
?>