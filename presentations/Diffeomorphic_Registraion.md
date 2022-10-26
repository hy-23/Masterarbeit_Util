# Diffeomorphic Registration vs Non-Diffeomorphic Registration
- **Change006** is the result of diffeomorphic registration (int_steps = 7)
- **Change005** is the result of non-diffeomorphic registration (int_steps = 0)
- It can be noticed that visual appearance of diffeomorphic registration looks much better than non-diffeomorphic registration.
![np_brain2_scaled](https://user-images.githubusercontent.com/46209868/184921871-60e2ccbc-dbf8-4b81-b59b-656f8d49a1d2.jpg)
- However, the `mmi score` for non-diffeomorphic registration is much higher. Can also be seen in the above image.
![plot](https://user-images.githubusercontent.com/46209868/184922760-983ff4e8-3a97-4860-8ddb-88be7594307e.jpg)
From the above plot, it can be seen that `non-diffeomorphic` registration has **always** performed better than `diffeomorphic` registration.
[Diffeomorphic_Registration_With_and_Without.xlsx](https://github.com/hy-23/Masterarbeit/files/9352465/Diffeomorphic_Registration_With_and_Without.xlsx)

- It is also observed that prediction using `non-diffeomorphic` trained weights is just around 1.6s, whereas, the prediction using `diffeomorphic` trained weights is around 6s.
  - **Diffeomorphic registration**
  >      Predicted:            np_58E02_32D11_MB043B_021713B_scaled.npz
  >      Time for prediction:  6.148828029632568
  > [predicted_time_diffeomorphic.txt](https://github.com/hy-23/Masterarbeit/files/9352550/predicted_time_diffeomorphic.txt)
  - **Non-diffeomorphic registration**
  >      Predicted:           np_58E02_32D11_MB043B_021713B_scaled.npz
  >      Time for prediction: 1.8648343086242676
  > [predicted_time_non-diffeomorphic.txt](https://github.com/hy-23/Masterarbeit/files/9352551/predicted_time_non-diffeomorphic.txt)
