const { app, BrowserWindow, Tray, Menu } = require('electron');
const path = require('path');

let tray;
let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1578,
        height: 912,
        icon: path.join(__dirname, 'src/assets/logo.png'), // 应用程序图标路径
        webPreferences: {
            preload: path.join(__dirname, 'preload.js'), // 预加载文件
            nodeIntegration: false, // 出于安全考虑，建议禁用 Node 集成
            contextIsolation: true, // 启用上下文隔离
        },
    });

    // 去掉默认菜单
    Menu.setApplicationMenu(null);

    // 加载开发或生产模式下的文件
    // mainWindow.loadURL('http://localhost:7436/Yoko'); // 开发模式
    mainWindow.loadFile(path.join(__dirname, 'dist/index.html')); // 生产模式

    // 监听窗口关闭事件
    mainWindow.on('closed', () => {
        mainWindow = null;
    });
}

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit();
});

app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
});

// 创建托盘图标
app.on('ready', () => {
    const trayIconPath = path.join(__dirname, 'src/assets/logo.png'); // 托盘图标路径
    tray = new Tray(trayIconPath);

    // 创建托盘菜单
    const contextMenu = Menu.buildFromTemplate([
        {
            label: '打开',
            click: () => {
                if (mainWindow) {
                    mainWindow.show();
                }
            }
        },
        {
            label: '退出',
            click: () => {
                app.quit();
            }
        }
    ]);

    // 设置托盘菜单
    tray.setToolTip('这是托盘图标的提示');
    tray.setContextMenu(contextMenu);

    // 监听托盘图标点击事件
    tray.on('click', () => {
        if (mainWindow) {
            mainWindow.isVisible() ? mainWindow.hide() : mainWindow.show();
        }
    });
});

// 退出时清理托盘
// app.on('before-quit', () => {
//     if (tray) {
//         tray.destroy();
//     }
// });
