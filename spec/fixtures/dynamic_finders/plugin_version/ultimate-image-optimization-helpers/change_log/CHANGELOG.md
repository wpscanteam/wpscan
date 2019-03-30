- ** Release 0.2.10 January 14th 2018 **
              - Fix: Setting the quality to "WP Default" not working and deactivates completely compression.
              
- ** Release 0.2.9 January 7th 2018 **
              - Added feature: constrain original image dimension so the full size is never bigger than Max Retina resolution x2: Max Width = 5012 & Max Height = 2880.
              
- ** Release 0.2.8 January 6th 2018 **
              - Fix: PHP notice.
              
- ** Release 0.2.7 January 5th 2018 **
              - Updated README file.

- ** Release 0.2.6 January 4th 2018 **
              - Fix: removed unsafe & unnecessary testing code.

- ** Release 0.2.5 January 3rd 2018 **
              - Changed plugin slug & text-domain.
              
- ** Release 0.2.3 December 5th 2017 **
              - Fix: filter hdev_optimg_set_conversion wrongly set to hdev_optimg_set_mode in class HDEV_OPTIMG_Optimize.

- ** Release 0.2.2 December 4rd 2017 **
              - Added png to jpeg conversion feature
              - Admin interface tweaks. 
              - Fix: unable to set the custom compression rate (field was disabled.)
              - Minor fixes and adjustments.

- ** Release 0.1.3 December 3rd 2017 **
              - Code modularity improvements: added methods get_optimization_quality, get_optimization_setting & get_adjusted_size_params to class HDEV_OPTIMG_Optimize.
              - Fix: jpeg quality was too low when image was cropped, scaled or rotated from the edit image screen.
              
- ** Release 0.1.1 December 1st 2017 **
              - Minor fix: wp_editor_set_quality filter set to 100 to disable WP compression added only if optimization is active.

- ** Release 0.1.0 December 1st 2017 - First commit **
