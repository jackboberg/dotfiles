require 'rake'

def linkables
  linkables = Dir.glob(File.join(ENV["HOME"], '.dotfiles', '*/**{.symlink}'))
  # Add dropbox configuration if present
  private_dir = File.join(ENV["HOME"], "Dropbox/.dotfiles")
  if File.directory?(private_dir)
    linkables |= Dir.glob(private_dir+'/**/*{.symlink}')
  end
  linkables
end

desc "Symlink our dotfiles into system-standard positions."
task :install do
  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false
    skip = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts """File already exists: #{target}, what do you want to do?
  [s]kip, [S]kip all
  [o]verwrite, [O]verwrite all
  [b]ackup, [B]ackup all"""
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then skip = true
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    `ln -s "#{linkable}" "#{target}"` if !skip && !skip_all
  end
end

desc "Remove dotfile symlinks"
task :uninstall do
  linkables.each do |linkable|
    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
    end

  end
end

task :default => 'install'
