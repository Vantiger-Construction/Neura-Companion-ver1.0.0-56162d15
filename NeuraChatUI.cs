using UnityEngine;
using UnityEngine.UI;

public class NeuraChatUI : MonoBehaviour {
    public InputField inputField;
    public Button sendButton;
    public Text chatContent;
    public NeuraMobileController neura;

    void Start() {
        sendButton.onClick.AddListener(OnSendClick);
    }

    void OnSendClick() {
        string msg = inputField.text.Trim();
        if (string.IsNullOrEmpty(msg)) return;
        chatContent.text += "\nYou: " + msg;
        inputField.text = "";
        neura.SendChat(msg);
    }

    public void AddNeuraMessage(string msg) {
        chatContent.text += "\nNeura: " + msg;
    }
}
