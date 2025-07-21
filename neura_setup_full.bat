@echo off
setlocal ENABLEEXTENSIONS

:: CONFIG
set UNITY_PROJECT_DIR=NeuraUnityMobile
set SCENE_NAME=NeuraDemoScene

:: STEP 1: Create project folders if missing
echo [📁] Preparing project structure...
mkdir %UNITY_PROJECT_DIR%\Assets\Neura\Scripts
mkdir %UNITY_PROJECT_DIR%\Assets\Neura\UI
mkdir %UNITY_PROJECT_DIR%\Assets\Neura\Scenes

:: STEP 2: Write NeuraChatUI.cs
echo [📜] Writing NeuraChatUI.cs...
(
echo using UnityEngine;
echo using UnityEngine.UI;
echo public class NeuraChatUI : MonoBehaviour {
echo     public InputField inputField;
echo     public Button sendButton;
echo     public Text chatContent;
echo     public NeuraMobileController neura;
echo     void Start() { sendButton.onClick.AddListener(OnSendClick); }
echo     void OnSendClick() {
echo         string msg = inputField.text.Trim();
echo         if (string.IsNullOrEmpty(msg)) return;
echo         chatContent.text += "\nYou: " + msg;
echo         inputField.text = "";
echo         neura.Se
cccc