## 🕹 FiveM-RadialMenu

Welcome to the **FiveM RadialMenu** repository!

## 🚀 Showcase
![script preview](https://github.com/YannisBnb/FiveM-RadialMenu/blob/main/preview.gif)

## 📋 Description
This mod adds the following:

- Multiple options can be added into the menu.
- Works for all jobs by adding which jobs can use which options when the menu is open.
- Triggers client events which can be in other resources making it easy to setup with other scripts.
- Easy to use via keybind to access the menu.
- This is for the radial menu only and not the other scripts' events which are opening in the video.

## 🖥️ Usage
- Press the keybind for the menu (default: "M") and hold.
- Move the mouse over to the option and click with your left mouse button.
- This will either do the action you use to do or open another sub menu.

## ⚙️ Installation
Add to your resources folder.
Write `start np-menu` (or your resource name) in your server.cfg.

### ACE permissions
The menu now uses ACE permissions instead of ESX jobs:

- `radialmenu.police` – enables the Police menu and its actions.
- `radialmenu.medic` – enables the Medical menu and its actions.

Example in `server.cfg`:

```
add_ace group.police radialmenu.police allow
add_ace group.ems radialmenu.medic allow
```

To add your own events or jobs to this make the event you wish into a client event.
Then write the event name in where you want it to trigger it in the config file.

To add a permission check to an option so only certain players will see it add the following to the return:

```
return (hasAcePermission('your.permission') and not isDead)
```
- Replace `'your.permission'` with your desired ACE permission.

### Default actions
- Police items are wired to the following client events: `police:cuffFromMenu`, `police:dragFromMenu`, `police:putInVehicleFromMenu`, `police:checkLicenses`, `police:removeWeapon`, `escortPlayer`, `startSpeedo`, `clientcheckLicensePlate`, and `police:frisk`.

## 🤝 Contributing

Your contributions make the open source community a fantastic place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ✉️ Contact

For any questions or suggestions, please feel free to contact me:

[![Discord](https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/w92W7XR9Yg)
[![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:deadgolden9122@gmail.com)
[![Steam](https://img.shields.io/badge/steam-%23000000.svg?style=for-the-badge&logo=steam&logoColor=white)](https://steamcommunity.com/id/DeAdGoLdEn/)

## 💖 Support Me

If you find this project helpful and would like to support my work, you can contribute through PayPal. Any support is greatly appreciated and helps me continue developing and maintaining the project.

[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/DeadGolden0)
