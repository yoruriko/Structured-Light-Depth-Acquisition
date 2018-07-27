
load('calibration/real_calibration/Calib_Results_Camera_1.mat');
cam_intrinsic = KK;
cam_extrinsic = [Rc_1,Tc_1];

load('calibration/real_calibration/Calib_Results_Projection_1.mat');
proj_intrinsic = KK;
proj_extrinsic = [Rc_1,Tc_1];
