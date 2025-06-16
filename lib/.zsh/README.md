### **`.zshenv`**
- **When loaded**: Always, for every shell (login, non-login, interactive, non-interactive)
- **Purpose**: Environment variables that should be available to all processes
- **Use for**: `PATH`, `EDITOR`, `BROWSER`, etc.
- **Note**: Keep it lightweight since it's loaded most frequently

### **`.zprofile`**
- **When loaded**: Login shells only (before `.zshrc`)
- **Purpose**: Commands that should run once per login session
- **Use for**: Starting services, setting up session-wide configurations
- **Equivalent**: Similar to `.bash_profile`

### **`.zshrc`**
- **When loaded**: Interactive shells (both login and non-login)
- **Purpose**: Interactive shell configuration
- **Use for**: Aliases, functions, prompt, key bindings, completions, plugins
- **Note**: This is where most of your customization goes

### **`.zlogin`**
- **When loaded**: Login shells only (after `.zshrc`)
- **Purpose**: Commands that should run after the shell is fully configured
- **Use for**: Displaying system info, running cleanup tasks

### **`.zlogout`**
- **When loaded**: When login shells exit
- **Purpose**: Cleanup tasks when logging out
- **Use for**: Clearing temporary files, saving history, etc.

## Shell Types Explained

### **Login Shell**
- Started when you log into the system
- Examples: SSH sessions, TTY login, `zsh -l`
- **Loads**: `.zshenv` → `.zprofile` → `.zshrc` → `.zlogin`

### **Non-login Interactive Shell**
- Started from within another shell or terminal emulator
- Examples: Opening a new terminal window/tab
- **Loads**: `.zshenv` → `.zshrc`

### **Non-interactive Shell**
- Runs scripts or commands without user interaction
- Examples: Shell scripts, command execution via SSH
- **Loads**: `.zshenv` only

## Terminal app

Typically a **non-login interactive shell**. Here's how to check:

```bash
# Check if it's a login shell
echo $0
# If output starts with '-' (like '-zsh'), it's a login shell
# If output is just 'zsh', it's a non-login shell

# Alternative check
[[ -o login ]] && echo "Login shell" || echo "Non-login shell"

# Check if interactive
[[ -o interactive ]] && echo "Interactive" || echo "Non-interactive"
```