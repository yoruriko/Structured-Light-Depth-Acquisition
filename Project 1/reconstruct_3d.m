close all;
clear ;

imageFileName = 'test_synthetic/cube_T1';
imagePrefix = '';
savePlyFileName = 'result_ply/test.ply';

% load in the image soruce under gray code pattern
images = load_sequence_color(imageFileName,imagePrefix,0,39,4,'png');

% decode uv gray code pattern to obtain a uv_code at each position
uv_code = decode_uv(images(:,:,:,1:20),images(:,:,:,21:40),1.0);
uv_code = filter_code(uv_code);

% load in the camera caliration for depth estimation

load_given_synthetic_calibration;
%load_estimate_synthetic_calibration;
%load_real_calibration;
%load_own_calibration;

% computing the unique depth map of provided data-set
w = compute_depth(uv_code,cam_intrinsic,cam_extrinsic,proj_intrinsic,proj_extrinsic);

% save the result into .ply format for visualization
save_ply(w,savePlyFileName);