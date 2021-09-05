<?php

use Phalcon\Http\Response as Response;

class PasienController extends \Phalcon\Mvc\Controller
{

    public function indexAction()
    {

    }

    public function saveAction()
    {
    	$this->view->disable();

    	$res = new Response;

    	$emp_id = $this->request->getPost("emp_id");

    	if($emp_id == ''){

	    	$create = new Pasien();

	    	$create->assign(array(
	    		'emp_name' => $this->request->getPost('InputName'),
	    		'emp_sex' => $this->request->getPost('InputSex'),
	    		'emp_religion' => $this->request->getPost('InputReligion')
				'emp_phone' => $this->request->getPost('Inputphone'),
	    		'emp_address' => $this->request->getPost('InputSAddress'),
	    		'emp_nik' => $this->request->getPost('InputNik')
	    	));
		    }else{

	    	$emp = Pasien::findFirst($emp_id);
	      	$emp->emp_id = $emp_id;
	   		$emp->emp_name = $this->request->getPost("InputName");
	   		$emp->emp_sex = $this->request->getPost("InputSex");
	   		$emp->emp_religion = $this->request->getPost("InputReligion");
			$emp->emp_phone = $this->request->getPost("InputPhone");
	   		$emp->emp_address = $this->request->getPost("InputSAddress");
	   		$emp->emp_nik = $this->request->getPost("InputNik");

	   		$action = $emp->save();
	    }

   		if (! $action) {
			$return = array('return' => false, 'msg' => 'Error ! while saving data');
		} else {
			$return = array('return' => true);
		}

    	$res->setContent( json_encode( $return ) );

   		return $res;
    }    

    public function editAction(){
    	$this->view->disable();

    	$res = new Response;

    	$id = $this->request->getPost('id');
   		$emp = Pasien::findFirst($id);

   		$res->setContent( json_encode( array(
   			'emp_id'=>$emp->emp_id,
   			'emp_name'=>$emp->emp_name,
   			'emp_sex'=>$emp->emp_sex,
   			'emp_religion'=>$emp->emp_religion,
			'emp_phone'=>$emp->emp_phone,
   			'emp_address'=>$emp->emp_address,
   			'emp_nik'=>$emp->emp_nik  
   		) ) );
    }

    public function deleteAction()
    {
    	$this->view->disable();

    	$res = new Response;

    	$id = $this->request->getPost('emp_id');
   		$emp = Pasien::findFirst($id);

   		if (! $emp->delete()) {
			$return = array('return' => false, 'msg' => 'Error ! while deleting data');
		} else {
			$return = array('return' => true);
		}

    	$res->setContent( json_encode( $return ) );

   		return $res;
    }

}

