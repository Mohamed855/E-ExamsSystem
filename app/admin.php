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
//	$db = Database::getInstance();
    //$con = $db->getConnection();
  //$con =$db->getConnection();
	$a=array();
	if($action=="getrequestdata"){

		$f = new Adminactions;
		$f->getRequestdata();
		//getRequestdata();
	}else if($action=="getsubject"){
		$f = new Adminactions;
		$f->getSubject();
		
		//getSubject();
	}else if($action=="getprofessordata"){
		$f = new Adminactions;
		$f->getProfessorData();
		
		//getProfessorData();
		}else if ($action=="send_request") {
		$table=$_POST['type'];
		$nationalid=$_POST['Nationalid'];
		$email=$_POST['Email'];
		$password=$_POST['Password'];
		$name=$_POST['realName'];
		$graduted=$_POST['graduted'];
		$age=$_POST['age'];
		$f = new Adminactions;
		$f->sendRequest($table, $name,$email,$nationalid,$password, $graduted, $age);
		
		//sendRequest($table, $name,$email,$nationalid,$password, $graduted, $age);
	}else if ($action=="check_your_email_and_password"){
		$email=$_POST['email'];
		$f = new Adminactions;
		$f->checkYourEmailAndPassword($email);
		//checkYourEmailAndPassword($email);
	}else if ($action=="rejected"){
		$id=$_POST['id'];
		$f = new Adminactions;
		$f->rejected($id);
		
		//rejected($id);
	}else if ($action=="accept"){
		$id=$_POST['id'];
		$type=$_POST['type'];
		$nationalid=$_POST['Nationalid'];
		$email=$_POST['Email'];
		$password=$_POST['Password'];
		$realName=$_POST['realName'];
		$graduted=$_POST['graduted'];
		$age=$_POST['age'];
		$f = new Adminactions;
		$f->accept($nationalid, $email,$realName,$password,$id,$graduted,$age,$type);
		
		//accept($nationalid, $email,$realName,$password,$id,$graduted,$age,$type);
	}else if ($action=="add_department"){
		$name=$_POST['name'];
		$whenstart=$_POST['whenstart'];
		$leader=$_POST['leader'];
		$f = new Adminactions;
		$f->addDepartment($name, $whenstart,$leader);
		
		//addDepartment($name, $whenstart,$leader);
	}else if ($action=="addsubject"){
		$name=$_POST['name'];
		$department=$_POST['department'];
		$professor=$_POST['professor'];
		$level=$_POST['level'];
		$semester=$_POST['semester'];
		$f = new Adminactions;
		$f->addSubject($name, $department,$professor,$level,$semester);
		
		//addSubject($name, $department,$professor,$level,$semester);
	}else if($action=="getdepartmentdata"){
		$f = new Adminactions;
		$f->getDepartmentData();
		
//		getDepartmentData();
	}else if ($action=="updatesubject"){
		$name=$_POST['name'];
		$department=$_POST['department'];
		$level=$_POST['level'];
		$semester=$_POST['semester'];
		$professor=$_POST['professor0000'];
		$id=$_POST['id'];
		$f = new Adminactions;
		$f->updateSubject($name,$department,$professor,$level,$semester,$id);;
		
		//updateSubject($name,$department,$professor,$level,$semester,$id);
	}
class Adminactions{ 
	
	//check if every any on the name of subject, for department, which professor will tech it, for which level and in which semester and update it
	function updateSubject($name,$department,$professor,$level,$semester,$id){
		global $db;
		$db= Connection::getInstance();
    	
		if($name!=null){
	   		$db->query("UPDATE Subject SET Name='".$name."' WHERE id=".$id);			
		}
		if($semester!=null){
	   		$sql = "UPDATE Subject SET semester='$semester' WHERE id=$id";	
	   		$db->query($sql);		
		}
		if($level!=null){
	   		$sql = "UPDATE Subject SET level='$level' WHERE id=$id";	
	   		$db->query($sql);		
		}
	   		
		if($professor!=null){
			global $db;
		   	$sql = "UPDATE Subject SET professor='$professor' WHERE id=$id";	
	   		$db->query($sql);		
		}
		if($department!=null){
			global $db;
	   		$sql = "UPDATE Subject SET department='$department' WHERE id=$id";	
	   		$db->query($sql);		
		}
	}
	
	//get the requests data
	function getRequestdata(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM request") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	//get the department data
	function getDepartmentData(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM Department") as $result){
			$a[]=$result;
		}
		echo json_encode($a);
	}
	//get the subject data
	function getSubject(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM Subject") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	//get professor data
	function getProfessorData(){
		global $db;
		$db= Connection::getInstance();
    	
   		foreach ($db->query("SELECT * FROM Professor") as $result){
			$a[]=$result;
		}
		echo json_encode($a);
	}
	//send the requeset if you are admin or professor
	function sendRequest($table, $name,$email,$nationalid,$password, $graduted, $age){
		$db= Connection::getInstance();
    	
		global $db;
		global $a;
		foreach ($db->query("SELECT * FROM request ;") as $result){
   		$a[]=$result;
		}
		if($table=='Professor'){
			foreach ($db->query("SELECT * FROM Professor ;") as $result){
   		$a[]=$result;
		}
	}else if($table=='Admin'){
		foreach ($db->query("SELECT * FROM Admin ;") as $result){
   		$a[]=$result;
		}
	}
		for($i=0;$i<count($a);$i++){
			if($a[$i]['Nationalid']==$nationalid){
				echo"Nationalid used";
			return "used";
			}
			if($a[$i]['Email']==$email){
				echo"email used";
			return "used2";
			}
		}
		try{
			$state=$db->prepare("INSERT INTO request(type,Nationalid,Email,Password,realName,graduted,age)VALUES('$table',$nationalid,'$email','$password','$name','$graduted',$age)");
			$state->execute();
    		echo "Done";
    	}catch(PDOException $e){
			echo "failed"." ".$e->getMessage();
		}
	}
	//when login get the all data when the email is equal the email you enter
	function checkYourEmailAndPassword($email){
    	global $db;
		$db= Connection::getInstance();
    	foreach ($db->query("SELECT * FROM Admin WHERE Email='$email'") as $result) {
    		$a[]=$result;
		}
		echo json_encode($a);
	}
	//when admin reject request delete the request from database
	function rejected($id){
		global $db;
		$db= Connection::getInstance();
    	
   		try{
			$sql="DELETE FROM request WHERE ID='$id'";
			$db->query($sql);
			echo "dooneee";		
		}catch(PDOException $e){
				echo "failed"." ".$e->getMessage();
		}
	}
	//when admin accept request delete it from request table after add it to its table
	function accept($nationalid, $email,$realName,$password,$id,$graduted,$age,$type){
		global $db;
		$db= Connection::getInstance();
    	
		if ($type == 'Professor') {

			try{
			$state=$db->prepare("INSERT INTO Professor(Nationalid,Email,Password,realName,graduted,age)VALUES($nationalid,'$email','$password','$realName','$graduted',$age)");
				
			$state->execute();
    		
				$sql="DELETE FROM request WHERE ID='$id'";
				$db->query($sql);
				echo "doone";
			}catch(PDOException $e){
				echo "failed"." ".$e->getMessage();
			}
    	} else if ($type == 'Admin') {
    		try{
				$state=$db->prepare("INSERT INTO Admin(Nationalid,Email,Password,realName,graduted,age)VALUES($nationalid,'$email','$password','$realName','$graduted',$age)");
				$state->execute();
    			$sql="DELETE FROM request WHERE ID='$id'";
					$db->query($sql);
					echo "dooneee";
			}catch(PDOException $e){
				echo "failed"." ".$e->getMessage();
			}
	    }
	}
	//add new department to database
	function addDepartment($name, $whenstart,$leader){
		global $db;
		$db= Connection::getInstance();
    	
		foreach ($db->query("SELECT * FROM Department ;") as $result){
   		$a[]=$result;
		}
		for($i=0;$i<count($a);$i++){
			if($a[$i]['Name']==$name){
				echo"name used";
			return "used";
			}
			
		}
		try{
			$state=$db->prepare("INSERT INTO Department(Name,whenstart,leader)VALUES('$name','$whenstart','$leader')");
			$state->execute();
    		echo "Doned";
    	}catch(PDOException $e){
			echo "failed"." ".$e->getMessage();
		}
	}
	//add new subject to database
	function addSubject($name, $department,$professor,$level,$semester){
		global $db;
		$db= Connection::getInstance();
    	
		foreach ($db->query("SELECT * FROM Subject ;") as $result){
   		$a[]=$result;
		}
		for($i=0;$i<count($a);$i++){
			if($a[$i]['Name']==$name){
				echo"name used";
			return "used";
			}
			
		}
		echo"ff";
		try{
			$state=$db->prepare("INSERT INTO Subject(Name,department,professor,level,semester,counter)VALUES('$name','$department','$professor','$level','$semester','0')");
			$state->execute();
    		echo "Doned";
    	}catch(PDOException $e){
			echo "failed"." ".$e->getMessage();
		}
	}
	}
	
	

?>