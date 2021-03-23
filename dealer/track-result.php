<?php
include('header.php');

include('../connection.php'); 


?>

<div id="page-wrapper">
  <div class="graphs">
    <h3 class="blank1" align="center"> Status Details </h3>
    <div class="col-sm-12">
      <div class="col-sm-2">
      </div>
      <div class="col-sm-2">
      </div>
    </div>
    <div class="tab-content">
      <div class="tab-pane active" id="horizontal-form">
        <form class="form-horizontal" action="" method="post" enctype="multipart/form-data">
        
            <div class="form-group">
              <label for="focusedinput" class="col-sm-2 control-label">booking id:</label>
              <div class="col-sm-8">
          <input type="text" class="form-control1" name="bid" placeholder="booking" required="" id="dearname">
              </div>
            </div>

              <div class="form-group">
              <label for="focusedinput" class="col-sm-2 control-label">Sender name :</label>
              <div class="col-sm-8">
                <input type="text" class="form-control1" name="sname" placeholder="Enter sender name" required="" id="dearname">
              </div>
            </div>

            <div class="form-group">
              <label for="focusedinput" class="col-sm-2 control-label">current city:</label>
              <div class="col-sm-8">
                <input type="text" class="form-control1" name="city" placeholder="current city" required="" id="dearname">
              </div>
            </div>

              
            <div class="form-group">
              <label for="focusedinput" class="col-sm-2 control-label">status</label>
              <div class="col-sm-8">
                <input type="text" class="form-control1" name="status" placeholder="status" required="" >
              </div>
            </div>
            <div class="form-group">
              <label for="focusedinput" class="col-sm-2 control-label">comments</label>
              <div class="col-sm-8">
                <input type="text" class="form-control1" name="cmnt" placeholder="comments" required="" id="dearname">
              </div>
            </div>

              

            <div class="form-group">
              <label for="focusedinput" class="col-sm-2 control-label"></label>
              <div class="col-sm-8">
                <button type="Submit" class="btn btn-success" name="tbl_courrier_track">Submit</button>
                <a href=""><button type="button" class="btn btn-danger">Cancel</button></a>
              </div>
            </div>

          </form>
        </div>
      </div>
      <!--body wrapper start-->
    </div>
    <!--body wrapper end-->
  </div>


  <?php 
  

  if(isset($_REQUEST['tbl_courrier_track']))
  {

$bid=$_REQUEST['bid'];
$sname=$_REQUEST['sname'];
$city=$_REQUEST['city'];
$status=$_REQUEST['status'];
$cmnt=$_REQUEST['cmnt'];
$ccn="Book".time();

$sql="INSERT INTO `tbl_courier_track` (`id`, `booking_id`, `s_name`, `current_city`, `status`, `comments`,`ccn`) VALUES (NULL, '$bid', '$sname', '$city', '$status', '$cmnt','$ccn')";

    $res=mysqli_query($conn,$sql);

    if($res)
    {
      echo"<script>alert('edited sucessfully');window.location='track-result.php'</script>";
    }
    else
    {
      echo"<script>alert('error');window.location='track-result.php'</script>";

    }

  }
  ?>


