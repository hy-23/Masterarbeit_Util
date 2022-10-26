# The alignment of the ventricular nerve is faulty.

The moving image in question is moved_np_GL_53A06_AE_01_081209A_scaled.npz. Despite training about 60-70 epochs, the final registered result for moved_np_GL_53A06_AE_01_081209A_scaled is poor (the ventricular nerve).
From the deformation field for the 20th layer scaled to level 4, it is evident that the network does not recognize this misalignment of the ventricular nerve and calculates the deformation field as if a background were present.

I was under the impression that larger warp vectors would help, but they only amplify the size and don't let the network know there is a ventricular nerve.

<img width="512" alt="warped_np_GL_53A06_AE_01_081209A_scaled" src="https://user-images.githubusercontent.com/46209868/186612050-7a216f14-4ad2-47c5-819c-3ac274cdf9fc.png">


Possible solutions could be:
- Consider only the lower half of the image (where ventricular nerves are present) and compute one more loss.
- Maybe, mse loss computation is influenced by large background pixels because of which loss is always in the order of 0.0032 and below. Ideally, loss has to be computed only on foreground pixels i.e., total number of pixels for normalization should only be foreground pixels, and not foregoround + background.
