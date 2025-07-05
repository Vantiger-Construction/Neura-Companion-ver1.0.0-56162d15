@echo off
REM ===== Neura Companion Full Animation Kit Folder Setup =====

set ROOT=Neura_Companion_Character
mkdir %ROOT%
cd %ROOT%

REM Create major asset folders
mkdir SVG
mkdir SVG\head
mkdir SVG\body
mkdir SVG\arms
mkdir SVG\hands
mkdir SVG\legs
mkdir SVG\feet
mkdir Figma
mkdir PNGs

REM Head parts
echo [SVG code for face] > SVG\head\face.svg
echo [SVG code for left_eye] > SVG\head\left_eye.svg
echo [SVG code for right_eye] > SVG\head\right_eye.svg
echo [SVG code for left_eyebrow] > SVG\head\left_eyebrow.svg
echo [SVG code for right_eyebrow] > SVG\head\right_eyebrow.svg
echo [SVG code for mouth] > SVG\head\mouth.svg
echo [SVG code for hair] > SVG\head\hair.svg

REM Body
echo [SVG code for torso] > SVG\body\torso.svg
echo [SVG code for circuits] > SVG\body\circuits.svg

REM Arms - all poses
echo [SVG code for left arm straight] > SVG\arms\left_arm_straight.svg
echo [SVG code for right arm straight] > SVG\arms\right_arm_straight.svg
echo [SVG code for left arm bent] > SVG\arms\left_arm_bent.svg
echo [SVG code for right arm bent] > SVG\arms\right_arm_bent.svg
echo [SVG code for left arm raised] > SVG\arms\left_arm_raised.svg
echo [SVG code for right arm raised] > SVG\arms\right_arm_raised.svg

REM Hands - all gestures (add/remove as needed)
echo [SVG code for left hand thumbs up] > SVG\hands\left_hand_thumbs_up.svg
echo [SVG code for right hand thumbs up] > SVG\hands\right_hand_thumbs_up.svg
echo [SVG code for left hand fist] > SVG\hands\left_hand_fist.svg
echo [SVG code for right hand fist] > SVG\hands\right_hand_fist.svg
echo [SVG code for left hand peace] > SVG\hands\left_hand_peace.svg
echo [SVG code for right hand peace] > SVG\hands\right_hand_peace.svg
echo [SVG code for left hand ok] > SVG\hands\left_hand_ok.svg
echo [SVG code for right hand ok] > SVG\hands\right_hand_ok.svg
echo [SVG code for left hand point] > SVG\hands\left_hand_point.svg
echo [SVG code for right hand point] > SVG\hands\right_hand_point.svg
echo [SVG code for left hand rock on] > SVG\hands\left_hand_rock_on.svg
echo [SVG code for right hand rock on] > SVG\hands\right_hand_rock_on.svg
echo [SVG code for left hand wave] > SVG\hands\left_hand_wave.svg
echo [SVG code for right hand wave] > SVG\hands\right_hand_wave.svg
echo [SVG code for left hand heart] > SVG\hands\left_hand_heart.svg
echo [SVG code for right hand heart] > SVG\hands\right_hand_heart.svg
echo [SVG code for left hand salute] > SVG\hands\left_hand_salute.svg
echo [SVG code for right hand salute] > SVG\hands\right_hand_salute.svg
echo [SVG code for left hand snap] > SVG\hands\left_hand_snap.svg
echo [SVG code for right hand snap] > SVG\hands\right_hand_snap.svg
echo [SVG code for left hand crossed fingers] > SVG\hands\left_hand_crossed_fingers.svg
echo [SVG code for right hand crossed fingers] > SVG\hands\right_hand_crossed_fingers.svg
echo [SVG code for left hand shh] > SVG\hands\left_hand_shh.svg
echo [SVG code for right hand shh] > SVG\hands\right_hand_shh.svg
echo [SVG code for left hand clap] > SVG\hands\left_hand_clap.svg
echo [SVG code for right hand clap] > SVG\hands\right_hand_clap.svg
echo [SVG code for left hand handshake] > SVG\hands\left_hand_handshake.svg
echo [SVG code for right hand handshake] > SVG\hands\right_hand_handshake.svg

REM Legs - straight and bent
echo [SVG code for left leg straight] > SVG\legs\left_leg_straight.svg
echo [SVG code for right leg straight] > SVG\legs\right_leg_straight.svg
echo [SVG code for left leg bent] > SVG\legs\left_leg_bent.svg
echo [SVG code for right leg bent] > SVG\legs\right_leg_bent.svg

REM Feet
echo [SVG code for left foot] > SVG\feet\left_foot.svg
echo [SVG code for right foot] > SVG\feet\right_foot.svg

REM Readme and Figma placeholder
echo Neura Companion Animation Kit - Folder Map > README.md
echo (Optional: Paste your Figma .fig here) > Figma\README.txt

echo.
echo ==== Neura Companion Character Animation folders created! ====
tree /f
pause
