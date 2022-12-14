const { app, BrowserWindow } = require('electron')

const MAC_OS = 'darwin'

const createWindow = () => {
    // Create the browser window.
    const win = new BrowserWindow({
        width: 1150,
        height: 800
    })
    try {
        const developmentURL = 'http://localhost:3000'
        // const productionURL = ''
        win.loadURL(developmentURL)
    } catch (error) {
        console.error(error)
    }
}

// Start the application
app.whenReady().then(createWindow)

// Quit the application when all windows are closed.
app.on('window-all-closed', () => {
    // On macOS it is common for applications and their menu bar
    // to stay active until the user quits explicitly with Cmd + Q
    // or by clicking the "Quit" menu item in the application menu.
    if (process.platform !== MAC_OS) {
        app.quit()
    }
})