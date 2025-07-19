using UnityEditor;
using UnityEngine;
using UnityEngine.UI;
using UnityEditor.SceneManagement;

public static class NeuraAutoSetup {
    [MenuItem("Neura/Auto-Setup Chat UI & Scene")]
    public static void SetupChatUI() {
        var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene);
        GameObject canvasGO = new GameObject("Canvas", typeof(Canvas), typeof(CanvasScaler), typeof(GraphicRaycaster));
        Canvas canvas = canvasGO.GetComponent<Canvas>();
        canvas.renderMode = RenderMode.ScreenSpaceOverlay;

        // Input Field
        GameObject inputGo = new GameObject("InputField", typeof(RectTransform), typeof(CanvasRenderer), typeof(Image), typeof(InputField));
        inputGo.transform.SetParent(canvasGO.transform);
        InputField inputField = inputGo.GetComponent<InputField>();
        inputField.placeholder = CreatePlaceholder(inputGo.transform);
        SetRect(inputGo.GetComponent<RectTransform>(), new Vector2(0.5f,0), new Vector2(0.7f,0), new Vector2(0,30), new Vector2(0,10));

        // Send Button
        GameObject buttonGo = new GameObject("SendButton", typeof(RectTransform), typeof(CanvasRenderer), typeof(Image), typeof(Button));
        buttonGo.transform.SetParent(canvasGO.transform);
        Button sendButton = buttonGo.GetComponent<Button>();
        GameObject btnText = new GameObject("Text", typeof(RectTransform), typeof(CanvasRenderer), typeof(Text));
        btnText.transform.SetParent(buttonGo.transform);
        Text btnTComp = btnText.GetComponent<Text>();
        btnTComp.text = "Send";
        btnTComp.alignment = TextAnchor.MiddleCenter;
        SetRect(btnText.GetComponent<RectTransform>(), new Vector2(0,0), new Vector2(1,1), Vector2.zero, Vector2.zero);
        SetRect(buttonGo.GetComponent<RectTransform>(), new Vector2(0.75f,0), new Vector2(0.9f,0), new Vector2(0,30), new Vector2(0,10));

        // Scroll View
        GameObject scrollGo = new GameObject("ChatScrollView", typeof(RectTransform), typeof(ScrollRect), typeof(CanvasRenderer), typeof(Image), typeof(Mask));
        scrollGo.transform.SetParent(canvasGO.transform);
        SetRect(scrollGo.GetComponent<RectTransform>(), new Vector2(0.1f,0.2f), new Vector2(0.9f,0.6f), Vector2.zero, Vector2.zero);
        ScrollRect scrollRect = scrollGo.GetComponent<ScrollRect>();
        scrollRect.content = CreateChatContent(scrollGo.transform);
        scrollRect.vertical = true;
        scrollRect.horizontal = false;

        // Neura Controller
        var neuraGO = new GameObject("Neura");
        neuraGO.AddComponent<NeuraMobileController>();

        // Chat UI wires
        var uiGO = new GameObject("UIManager", typeof(NeuraChatUI));
        var ui = uiGO.GetComponent<NeuraChatUI>();
        ui.inputField = inputField;
        ui.sendButton = sendButton;
        ui.chatContent = scrollRect.content.GetComponent<Text>();
        ui.neura = neuraGO.GetComponent<NeuraMobileController>();

        // Wire button
        sendButton.onClick.AddListener(ui.OnSendClick);

        // Save
        EditorSceneManager.SaveScene(scene, "Assets/NeuraDemo.unity");
        Debug.Log("✅ Neura chat UI scene created! Open 'NeuraDemo' to view.");
    }

    static Text CreatePlaceholder(Transform parent) {
        var ph = new GameObject("Placeholder", typeof(RectTransform), typeof(CanvasRenderer), typeof(Text));
        ph.transform.SetParent(parent);
        var t = ph.GetComponent<Text>();
        t.text = "Type your message...";
        t.color = Color.gray;
        t.alignment = TextAnchor.MiddleLeft;
        SetRect(ph.GetComponent<RectTransform>(), new Vector2(0,0), new Vector2(1,1), Vector2.one * 5, Vector2.one * -5);
        return t;
    }

    static RectTransform CreateChatContent(Transform parent) {
        var contentGo = new GameObject("Content", typeof(RectTransform), typeof(CanvasRenderer), typeof(Text));
        contentGo.transform.SetParent(parent);
        var text = contentGo.GetComponent<Text>();
        text.text = "";
        text.alignment = TextAnchor.UpperLeft;
        text.horizontalOverflow = HorizontalWrapMode.Wrap;
        text.verticalOverflow = VerticalWrapMode.Overflow;
        SetRect(contentGo.GetComponent<RectTransform>(), new Vector2(0,0), new Vector2(1,1), Vector2.one * 10, Vector2.one * -10);
        return contentGo.GetComponent<RectTransform>();
    }

    static void SetRect(RectTransform rt, Vector2 min, Vector2 max, Vector2 offsetMin, Vector2 offsetMax) {
        rt.anchorMin = min;
        rt.anchorMax = max;
        rt.offsetMin = offsetMin;
        rt.offsetMax = offsetMax;
    }
}
