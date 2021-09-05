<div class="row"><br><br>
	<div class="col-sm-8 col-sm-offset-2">
  		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">New Pasien</button><br><br>
		<table class="table table-hover">
		  <thead>
		    <tr>
		      <th scope="col">Name</th>
		      <th scope="col">Sex</th>
		      <th scope="col">Religion</th>
			  <th scope="col">Phobe</th>
		      <th scope="col">Address</th>
		      <th scope="col">Nik</th>
		      <th scope="col"></th>
		    </tr>
		  </thead>
		  <tbody>
		  	{% for r in emp %}
		    <tr>
		      <td>{{r.emp_name}}</td>
		      <td>{{r.emp_sex}}</td>
		      <td>{{r.emp_religion}}</td>
			  <td>{{r.emp_phone}}</td>
		      <td>{{r.emp_address}}</td>
		      <td>{{r.emp_nik}}</td>
		      <td>
      			<a href='#exampleModal' class='btn btn-info btn-small' id='editId' data-toggle='modal' data-id="{{r.emp_id}}">Edit</a>
      			<a href='#deleteModal' class='btn btn-danger btn-small' id='deleteId' data-toggle='modal' data-id="{{r.emp_id}}">Delete</a>
		      </td>
		    </tr>
		    {% endfor %}
		  </tbody>
		</table>
	</div>
</div>

<!-- Form Pasien -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title">Form Pasien</h4>
      </div>
      <div class="modal-body">
        <form id="frmEmployee">
		  <div class="form-group">
		    <label for="InputName">Name</label>
		    <input type="hidden" id="emp_id" name="emp_id">
		    <input type="text" class="form-control" id="emp_fullname" name="InputName" placeholder="Enter full name">
		  </div>	  
		  <div class="form-group">
		    <label for="InputSex">Sex</label>
		    <input type="text" class="form-control" id="emp_sex" name="InputSex" placeholder="Enter Sex">
		  </div>	  
		  <div class="form-group">
		    <label for="InputReligion">Religion</label>
		    <input type="text" class="form-control" id="emp_religion" name="InputReligion" placeholder="Enter Religion">
		  </div>
		</div>
		  <div class="form-group">
		    <label for="InputPhone">Phone</label>
		    <input type="text" class="form-control" id="emp_phone" name="InputPhone" placeholder="Enter Phone">
		  </div>
		  <div class="form-group">
		    <label for="InputAddress">Address</label>
		    <input type="text" class="form-control" id="emp_address" name="InputAddress" placeholder="Enter Address">
		  </div>
		  <div class="form-group">
		    <label for="InputNik">Nik</label>
		    <input type="number" class="form-control" id="emp_nik" name="InputNik" placeholder="Enter Nik">
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" onclick="savePasien()" class="btn btn-primary">Save</button>
      </div>
    </div>
  </div>
</div>
<!-- Form Pasien -->

<!-- Prompt Deletion -->
<div class="modal fade" id="deleteModal" role="dialog">
	<div class="modal-dialog modal-sm">
	  <div class="modal-content">
	    <div class="modal-header">
	      <button type="button" class="close" data-dismiss="modal">&times;</button>
	      <h4 class="modal-title">Warning !</h4>
	    </div>
	    <div class="modal-body">
	    	<input type="hidden" id="emp_id_d" name="emp_id_d">
	      	<p>Are you sure to delete this Pasien ?</p>
	    </div>
	    <div class="modal-footer">
	     	<button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
        	<button type="button" onclick="deletePasien()" class="btn btn-primary">Yes</button>
	    </div>
	  </div>
	</div>
</div>
<!-- Prompt Deletion -->

<script>
$(document).ready(function(){
	$('#exampleModal, #deleteModal').on('shown.bs.modal', function (e) {
		var id = $(e.relatedTarget).data('id');
		if(! id){
			$('#emp_id').val('');
	    	$('#emp_id_d').val('');
	    	$('#emp_name').val('');
	    	$('#emp_sex').val('');
	    	$('#emp_religion').val('');
			$('#emp_phone').val('');
	    	$('#emp_address').val('');
	    	$('#emp_nik').val('');
		}else{
			$.ajax({
			    type : 'post',
			    url : 'pasien/edit',
			    data :  'id='+ id,
			    success : function(res){
			    	var obj = JSON.parse(res);

			    	$('#emp_id').val(obj.emp_id);
			    	$('#emp_id_d').val(obj.emp_id);
			    	$('#emp_name').val(obj.emp_name);
			    	$('#emp_sex').val(obj.emp_sex);
			    	$('#emp_religion').val(obj.emp_religion);
					$('#emp_phone').val(obj.emp_phone);
			    	$('#emp_address').val(obj.emp_address);
			    	$('#emp_nik').val(obj.emp_nik);
			    }
			});
		}
	});

});

function savePasien(){
	var obj;

	if($('#emp_name').val().trim() == ''){
		$('#emp_name').focus();
		return false;
	}

	if($('#emp_sex').val().trim() == ''){
		$('#emp_sex').focus();
		return false;
	}	

	if($('#emp_religion').val().trim() == ''){
		$('#emp_religion').focus();
		return false;
	}
	if($('#emp_phone').val().trim() == ''){
		$('#emp_phone').focus();
		return false;
	}

	if($('#emp_address').val().trim() == ''){
		$('#emp_address').focus();
		return false;
	}	

	if($('#emp_nik').val().trim() == ''){
		$('#emp_nik').focus();
		return false;
	}

	$.post( "pasine/save", $( "#frmPasien" ).serialize(), function(res){
		obj = JSON.parse(res);
		if(obj.return){
			$('#exampleModal').modal('hide');
			location.reload();
		}else{
			alert(obj.msg);
		}
	});
	
}

function deletePasien(){
	var obj, id = $('#emp_id_d').val();

	$.post( "pasien/delete", {emp_id:id}, function(res){
		obj = JSON.parse(res);
		if(obj.return){
			$('#deleteModal').modal('hide');
			location.reload();
		}else{
			alert(obj.msg);
		}
	});	
}

</script>