require 'java_imports.rb'

require 'yaml'
require 'thread'

class TopFrame < JFrame

  def initialize
    super "SSH Connections"
    init_ui_components()
    pack()
    set_visible(true)
  end

  def init_ui_components()

    # default linux setting, uses the keys in the user's .ssh directory
    @identity_file = ""

    # use putty on windows, gnome on linux and Terminal on mac
    @islinux = RUBY_PLATFORM.downcase.include?("linux")
    @ismac = RUBY_PLATFORM.downcase.include?("darwin")

    @connect_cmd = '"c:\Program Files\PuTTY\putty.exe" '
    if @islinux
       @connect_cmd = "gnome-terminal --execute ssh "
    elsif @ismac
       @connect_cmd = `osascript -e 'tell application "Terminal" to do script "ssh xxx"'`
    end

    # save the list of windows created, so garbage collection doesn't kill
    @save_sub_process = Array.new


    @config_file_yaml = "#{File.expand_path(File.dirname(__FILE__))}/settings.yaml"

    puts @config_file_yaml

    if File.exist? @config_file_yaml
      @yaml_data = YAML.load_file( @config_file_yaml )
    else
      puts "yaml file missing"
      exit
    end



    if (!@islinux && !@ismac)
      if @yaml_data['win_ssh_key'].length > 1
        @identity_file = " -i #{@yaml_data['win_ssh_key']} "
      end
    end



    contentPane = getContentPane()
    gridbag = GridBagLayout.new
    contentPane.setLayout gridbag

    grid = GridBagConstraints.new

    #setting a default constraint value
    grid.fill = GridBagConstraints::HORIZONTAL


    siteLbl = JLabel.new("Site:")
    grid.gridx = 0
    grid.gridy = 0
    gridbag.setConstraints(siteLbl, grid)
    contentPane.add(siteLbl)

    descLbl = JLabel.new("Description:")
    grid.gridx = 0
    grid.gridy = 1
    gridbag.setConstraints(descLbl, grid)
    contentPane.add(descLbl)

    userLbl = JLabel.new("user:")
    grid.gridx = 0
    grid.gridy = 2
    gridbag.setConstraints(userLbl, grid)
    contentPane.add(userLbl)

    siteCombo = JComboBox.new
    @yaml_data['sessions'].each_index do |i|
      siteCombo.addItem "#{@yaml_data['sessions'][i][0]['site']}"
    end
    grid.gridx = 1
    grid.gridy = 0
    grid.gridwidth = 1
    gridbag.setConstraints(siteCombo, grid)
    contentPane.add(siteCombo)

    siteCombo.add_action_listener do |e|
      puts siteCombo.getSelectedItem()
    end

    serverCombo = JComboBox.new
    serverCombo.addItem "localhost"
    serverCombo.addItem "127.0.0.1"
    grid.gridx = 1
    grid.gridy = 1
    grid.gridwidth = 1
    gridbag.setConstraints(serverCombo, grid)
    contentPane.add(serverCombo)

    userCombo = JComboBox.new
    userCombo.addItem "mikec"
    userCombo.addItem "root"
    grid.gridx = 1
    grid.gridy = 2
    grid.gridwidth = 2
    gridbag.setConstraints(userCombo, grid)
    contentPane.add(userCombo)


    connectBtn = JButton.new("Connect")
    grid.gridx = 0
    grid.gridy = 3
    gridbag.setConstraints(connectBtn, grid)
    contentPane.add(connectBtn)

    set_default_close_operation(JFrame::EXIT_ON_CLOSE)

    # don't set the size, let swing figure it out
    #set_preferred_size(Dimension.new(275, 175))
  end


end

SwingUtilities.invoke_later do
  TopFrame.new
end
