# LLMChat
LLM-powered in-game chat.

Requires LLMStudio and a LLM small enough to run quickly with your hardware.

<img width="1200" height="250" alt="LM Studio_3" src="https://github.com/user-attachments/assets/a8c39828-793b-425f-878d-175892c39add" />

Please be aware that responses to queries are almost guaranteed to be incorrect. This should be used purely for the entertainment value.

## Setup

1) Download and install [LM Studio](https://lmstudio.ai/) (it's free).

<img width="1407" height="872" alt="LM Studio_1" src="https://github.com/user-attachments/assets/0c460e31-3c81-426b-bc18-469d501c38f6" />

2) In LM Studio, click on the **Magnifying Glass** icon to pull up the **Model Search**. Select a model to use and click the **Download** button to the bottom right.
   - The model you choose is mostly based on your current hardware. I am currently running a very old GTX 1080 Ti that has 11GB of VRAM, but also has no Tensor Cores that are used to speed up and improve AI workloads. That said, I've been running LLMChat using the `qwen/qwen3-4b-2507` model and it has been just fine, with responses being returned within 1-2 seconds. Models with larger parameters take too long to generate a response using my hardware. You may be able to run larger parameter models that produce responses with speeds that are acceptable. I suggest starting with the **Qwen3 4B** model (already set to default in LLMChat), then experimenting with other models after you get everything up and running.

<img width="1407" height="872" alt="LM Studio_2" src="https://github.com/user-attachments/assets/272b9437-13e5-4a56-8d93-b08e9d486ff9" />

3) Once your model has downloaded, click on the **Discover** button above **Magnifying Glass** to bring up the **Developer** section.
4) Click on **Select a model to load** and click on your newly downloaded model. It should take just a moment to load.
5) Load LLMChat in FFXI using `//lua load llmchat`
   - LLMChat should be in it's own folder inside the addons folder: `addons\LLMChat\LLMchat.lua`
6) You should not need to edit the `lm_studio_url` in the `data\settings.xml` file. If you downloaded a different model than Qwen3 4B, click on the copy icon next to the model name under **This model's API identifier** and paste it into the `model_name` option in the settings file, otherwise, Qwen3 4B is already set as the default model.

**That's it!** Now you should be able to play with your new LLM personalities in FFXI.  
Type `//llm help` to get started.

## Useage

People in your chat (Party and Linkshell 1 and 2, **NOT** say) can interact with your personalities by starting a message with the name of a personality then following with a query. It will then generate a response to it and send it back to the same channel. Please note that this will of course be seen in the chat as coming from your player character, but it will have an identifier at the beginning of the reply as to which personality is responding.

You can interact with your personalities by using `//llm` then adding a channel to send the reply to, then the name of the personality, then the query. Available channels are **echo**, **party**, **linkshell**, and **linkshell 2**  
Example: `//llm ls altana introduce yourself to the linkshell` - This will send a generated response from Altana to linkshell 1 introducing herself.


## Personalities
I have included 6 personalities to get you started:
- Altana
- Boombox
- Brygid
- Moogle
- Odin
- Promathia

### Creating a new Personality
New personalities are extremely easy to create. Open the `dta\settings.xml` file, and create a new entry underneath the current personalities. Fill in the name you wish to give it, then add the prompt that explains how the personality should behave. To create the personalities included by default, I went to chatGPT and asked it to create a prompt specifically tailored to give to another LLM for this purpose. I then tested the prompt and adjusted it a few times.

------
<p align="center">
  <em>Support development in Vana'diel</em>
</p>

<p align="center">
  <a href="https://www.paypal.com/donate/?hosted_button_id=7NELJEHF84YRQ">
    <img src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" alt="Donate with PayPal">
  </a>
</p>

<p align="center">
  I have put hundreds of hours into creating these addons and GearSwap files.<br>
  All of my work is <em>Donate What You Want</em> - contribute whatever you feel it’s worth.
</p>

------
