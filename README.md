# Dotfiles management using Chezmoi

To use Chezmoi on another system, you need to follow these steps:

1. **Install Chezmoi:** Install Chezmoi on the new system by following the installation instructions specific to your operating system and instantly link to this repo:

   ```shell
   sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply Tanguille
   ```

   1b. **Apply Dotfiles:** If you are unsure about immediatly applying all dotfiles to your system, apply your dotfiles to the new system by running the following command:

   ```shell
   chezmoi apply
   ```

   Chezmoi will create the necessary symbolic links to configure your dotfiles based on the repository's contents.

2. **Update Dotfiles:** If you make any changes to your dotfiles on the new system, you can synchronize them back to the repository by running:

   ```shell
   chezmoi diff  # View the differences
   chezmoi update  # Update the repository with changes
   ```

   The `chezmoi diff` command shows the differences between the repository and your local dotfiles, while `chezmoi update` updates the repository with the changes you made.

By following these steps, you can easily use Chezmoi to manage your dotfiles across multiple systems, ensuring consistency and easy synchronization.
