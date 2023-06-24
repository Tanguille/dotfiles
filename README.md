# Dotfiles management using Chezmoi

To use Chezmoi on another system, you need to follow these steps:

1. **Install Chezmoi:** Install Chezmoi on the new system by following the installation instructions specific to your operating system, as mentioned in the [Installation](#installation) section of this README.

2. **Clone the Repository:** Clone your dotfiles repository on the new system using the following command:

   ```shell
   chezmoi init github.com/Tanguille/dotfiles
   ```

3. **Apply Dotfiles:** Apply your dotfiles to the new system by running the following command:

   ```shell
   chezmoi apply
   ```

   Chezmoi will create the necessary symbolic links to configure your dotfiles based on the repository's contents.

4. **Update Dotfiles:** If you make any changes to your dotfiles on the new system, you can synchronize them back to the repository by running:

   ```shell
   chezmoi diff  # View the differences
   chezmoi update  # Update the repository with changes
   ```

   The `chezmoi diff` command shows the differences between the repository and your local dotfiles, while `chezmoi update` updates the repository with the changes you made.

By following these steps, you can easily use Chezmoi to manage your dotfiles across multiple systems, ensuring consistency and easy synchronization.
