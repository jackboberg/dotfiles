#! /usr/bin/env node

const Path = require('path')
const getHomePath = require('home-path')

const getLinkables = (dirs) => {
  // async get all '$dir/**/*{.symlink}'
}
// create a symlink from src path to ~/.dotfiles
// post install npm link to make binaries

// './path/to/file.symlink' => '/Users/jack/.file'
const getTaget = (source) => {
  const baseName = Path.basename(source, '.symlink')
  return Path.join(getHomePath(), `.${baseName}`)
}

const link = (linkables, done) => {
  cosnt linkMap = linkables.map(getLinkableMap, {})

} 