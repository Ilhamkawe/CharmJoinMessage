using Rocket.API;

namespace CharmJoinMessage
{
    public class CharmJoinMessagePluginConfiguration : IRocketPluginConfiguration
    {
        public bool BroadcastJoinMessage { get; set; }
        public bool ShowWelcomeMessage { get; set; }
        public bool ShowWelcomeTitle { get; set; }
        public string JoinMessageColor { get; set; }
        public string WelcomeMessageColor { get; set; }
        public string WelcomeTitleColor { get; set; }
        public string AdditionalMessage { get; set; }
        public string AdditionalMessageColor { get; set; }
        public bool ShowPlayerCount { get; set; }
        public string PlayerCountColor { get; set; }

        public void LoadDefaults()
        {
            BroadcastJoinMessage = true;
            ShowWelcomeMessage = true;
            ShowWelcomeTitle = true;
            JoinMessageColor = "cyan";
            WelcomeMessageColor = "pink";
            WelcomeTitleColor = "magenta";
            AdditionalMessage = "Have fun and enjoy your adventure! ✨";
            AdditionalMessageColor = "gold";
            ShowPlayerCount = true;
            PlayerCountColor = "cyan";
        }
    }
}

