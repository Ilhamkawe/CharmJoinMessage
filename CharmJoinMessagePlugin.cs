using System;
using Rocket.API.Collections;
using Rocket.Core.Logging;
using Rocket.Core.Plugins;
using Rocket.Unturned.Chat;
using Rocket.Unturned.Events;
using Rocket.Unturned.Player;
using SDG.Unturned;
using UnityEngine;

namespace CharmJoinMessage
{
    public class CharmJoinMessagePlugin : RocketPlugin<CharmJoinMessagePluginConfiguration>
    {
        public static CharmJoinMessagePlugin Instance { get; private set; }

        protected override void Load()
        {
            Instance = this;
            PlayerEvents.OnPlayerConnected += OnPlayerConnected;
            Logger.Log("[CharmJoinMessage] Plugin loaded successfully!");
        }

        protected override void Unload()
        {
            PlayerEvents.OnPlayerConnected -= OnPlayerConnected;
            Logger.Log("[CharmJoinMessage] Plugin unloaded.");
            Instance = null;
        }

        public override TranslationList DefaultTranslations => new TranslationList
        {
            { "join_message", "✨ {0} has joined the server! ✨" },
            { "welcome_message", "Welcome to our server, {0}! We hope you enjoy your stay! 💖" },
            { "welcome_title", "╔═══════════════════════════════════╗" },
            { "welcome_title_middle", "║   ✨ Welcome to Our Server! ✨   ║" },
            { "welcome_title_end", "╚═══════════════════════════════════╝" }
        };

        private void OnPlayerConnected(UnturnedPlayer player)
        {
            if (player == null)
                return;

            try
            {
                // Broadcast join message to all players
                if (Configuration.Instance.BroadcastJoinMessage)
                {
                    var joinColor = GetColorFromString(Configuration.Instance.JoinMessageColor);
                    var joinMsg = Translate("join_message", player.DisplayName);
                    UnturnedChat.Say(joinMsg, joinColor);
                }

                // Send welcome message to the joining player
                if (Configuration.Instance.ShowWelcomeMessage)
                {
                    SendWelcomeMessage(player);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError($"[CharmJoinMessage] Error handling player join: {ex.Message}");
            }
        }

        private void SendWelcomeMessage(UnturnedPlayer player)
        {
            if (player == null)
                return;

            // Delay to ensure player is fully loaded
            Rocket.Core.Utils.TaskDispatcher.QueueOnMainThread(() =>
            {
                try
                {
                    // Send welcome title with decorative border
                    if (Configuration.Instance.ShowWelcomeTitle)
                    {
                        var titleColor = GetColorFromString(Configuration.Instance.WelcomeTitleColor);
                        UnturnedChat.Say(player, Translate("welcome_title"), titleColor);
                        UnturnedChat.Say(player, Translate("welcome_title_middle"), titleColor);
                        UnturnedChat.Say(player, Translate("welcome_title_end"), titleColor);
                    }

                    // Send main welcome message with charming style
                    var welcomeColor = GetColorFromString(Configuration.Instance.WelcomeMessageColor);
                    var welcomeMsg = Translate("welcome_message", player.DisplayName);
                    UnturnedChat.Say(player, welcomeMsg, welcomeColor);

                    // Send additional messages if configured
                    if (!string.IsNullOrEmpty(Configuration.Instance.AdditionalMessage))
                    {
                        var additionalColor = GetColorFromString(Configuration.Instance.AdditionalMessageColor);
                        UnturnedChat.Say(player, Configuration.Instance.AdditionalMessage, additionalColor);
                    }

                    // Send player count if enabled
                    if (Configuration.Instance.ShowPlayerCount)
                    {
                        var playerCount = Provider.clients.Count;
                        var playerCountColor = GetColorFromString(Configuration.Instance.PlayerCountColor);
                        var countMsg = $"There are currently {playerCount} player(s) online!";
                        UnturnedChat.Say(player, countMsg, playerCountColor);
                    }
                }
                catch (Exception ex)
                {
                    Logger.LogError($"[CharmJoinMessage] Error sending welcome message: {ex.Message}");
                }
            }, 0.5f); // 0.5 second delay
        }

        private Color GetColorFromString(string colorName)
        {
            if (string.IsNullOrEmpty(colorName))
                return Color.white;

            switch (colorName.ToLower())
            {
                case "pink":
                    return new Color(1f, 0.4f, 0.8f); // Bright pink
                case "magenta":
                    return new Color(1f, 0f, 1f); // Magenta
                case "cyan":
                    return Color.cyan;
                case "yellow":
                    return Color.yellow;
                case "green":
                    return Color.green;
                case "orange":
                    return new Color(1f, 0.5f, 0f); // Orange
                case "purple":
                    return new Color(0.6f, 0.2f, 1f); // Purple
                case "red":
                    return Color.red;
                case "blue":
                    return Color.blue;
                case "white":
                    return Color.white;
                case "gold":
                    return new Color(1f, 0.84f, 0f); // Gold
                case "coral":
                    return new Color(1f, 0.5f, 0.31f); // Coral
                case "lavender":
                    return new Color(0.9f, 0.9f, 0.98f); // Lavender
                case "rose":
                    return new Color(1f, 0.75f, 0.8f); // Rose pink
                case "mint":
                    return new Color(0.6f, 1f, 0.8f); // Mint green
                case "peach":
                    return new Color(1f, 0.9f, 0.7f); // Peach
                default:
                    return Color.white;
            }
        }
    }
}

