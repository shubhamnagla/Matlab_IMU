a = arduino('COM5', 'Uno', 'Libraries', 'I2C');
fs = 100;
imu = mpu9250(a,'SampleRate',fs,'OutputFormat','matrix'); 
GyroscopeNoiseMPU9250 = 3.0462e-06;
AccelerometerNoiseMPU9250 = 0.0061;
viewer = HelperOrientationViewer('Title',{'Visualization of Orientation'})
FUSE = ahrsfilter('SampleRate',imu.SampleRate, 'GyroscopeNoise',GyroscopeNoiseMPU9250,'AccelerometerNoise',AccelerometerNoiseMPU9250);
tic;
stopTimer = 100;
magReadings = [];
accelReadings = [];
gyroReadings = [];
while(toc<stopTimer)
    [accel,gyro,mag] = read(imu);
    magReadings = [magReadings;mag];
    accelReadings = [accelReadings;accel];
    gyroReadings = [gyroReadings;gyro];
    fuseReadings = FUSE(accel,gyro,mag);
    for j = numel(fuseReadings)
       viewer(fuseReadings(j));
    end
    subplot(3,2,1);
    plot(accelReadings);drawnow
    title('Accelerometer Readings');
    subplot(3,2,2);
    plot(gyroReadings);drawnow
    title('GyroScope Readings');
    subplot(3,1,3);
    plot(magReadings);drawnow
    title('Magnetometer Readings');
end
%%magx_min = min(magReadings);
%%magx_max = max(magReadings);
%%magx_correction = (magx_max+magx_min)/3;



