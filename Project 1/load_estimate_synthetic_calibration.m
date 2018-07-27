
load('calibration/synthetic_calibration/Calib_Results_Camera.mat');
cam_intrinsic = KK;
cam_extrinsic = [Rc_1,Tc_1];

load('calibration/synthetic_calibration/Calib_Results_Projection.mat');
proj_intrinsic = KK;
proj_extrinsic = [Rc_1,Tc_1];
