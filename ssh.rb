# -*- coding: utf-8 -*-

require 'java_imports.rb'

require 'yaml'
require 'thread'

class TopFrame < JFrame
  def initialize
    super 'SSH Connections'
    init_ui_components
    pack
    set_visible(true)
  end

  def init_ui_components

    # default linux setting, uses the keys in the user's .ssh directory
    @identity_file = ''

    # use putty on windows, gnome on linux and Terminal on mac
    @islinux = RbConfig::CONFIG['host_os'].downcase.include?('linux')
    @ismac = RbConfig::CONFIG['host_os'].downcase.include?('darwin')

    @connect_cmd_start = '"c:\Program Files\PuTTY\putty.exe" '
    @connect_cmd_end = ''
    if @islinux
      @connect_cmd_start = 'gnome-terminal --execute ssh '
      @connect_cmd_end = ''
    elsif @ismac
      @connect_cmd_start = 'osascript -e \'tell application "Terminal" to do script "ssh '
      @connect_cmd_end = '"\''
    end

    # save the list of windows created, so garbage collection doesn't kill
    @save_sub_process = []

    @config_file_yaml = "#{File.expand_path(File.dirname(__FILE__))}/settings.yaml"

    puts @config_file_yaml

    if File.exist? @config_file_yaml
      @yaml_data = YAML.load_file(@config_file_yaml)
    else
      puts 'yaml file missing'
      exit
    end

    if !@islinux && !@ismac
      if @yaml_data['win_ssh_key'].length > 1
        @identity_file = " -i #{@yaml_data['win_ssh_key']} "
      end
    end

    content_pane = getContentPane
    gridbag = GridBagLayout.new
    content_pane.setLayout gridbag

    grid = GridBagConstraints.new

    # setting a default constraint value
    grid.fill = GridBagConstraints::HORIZONTAL

    site_lbl = JLabel.new('Site:')
    grid.gridx = 0
    grid.gridy = 0
    gridbag.setConstraints(site_lbl, grid)
    content_pane.add(site_lbl)

    host_lbl = JLabel.new('Host:')
    grid.gridx = 0
    grid.gridy = 1
    gridbag.setConstraints(host_lbl, grid)
    content_pane.add(host_lbl)

    desc_lbl = JLabel.new('Description: ')
    grid.gridx = 0
    grid.gridy = 2
    gridbag.setConstraints(desc_lbl, grid)
    content_pane.add(desc_lbl)

    user_lbl = JLabel.new('User:')
    grid.gridx = 0
    grid.gridy = 3
    gridbag.setConstraints(user_lbl, grid)
    content_pane.add(user_lbl)

    @site_combo = JComboBox.new
    @yaml_data['sessions'].each_index do |i|
      @site_combo.addItem "#{@yaml_data['sessions'][i][0]['site']}"
    end

    grid.gridx = 1
    grid.gridy = 0
    grid.gridwidth = 1
    gridbag.setConstraints(@site_combo, grid)
    content_pane.add(@site_combo)

    @site_combo.add_action_listener do |e|
      site_change @site_combo.getSelectedItem
    end

    @host_combo = JComboBox.new
    grid.gridx = 1
    grid.gridy = 1
    grid.gridwidth = 1
    gridbag.setConstraints(@host_combo, grid)
    content_pane.add(@host_combo)

    @host_combo.add_action_listener do |e|
      host_change @host_combo.getSelectedItem
    end

    @desc_data_lbl = JLabel.new(' ')
    grid.gridx = 1
    grid.gridy = 2
    gridbag.setConstraints(@desc_data_lbl, grid)
    content_pane.add(@desc_data_lbl)

    @user_combo = JComboBox.new
    grid.gridx = 1
    grid.gridy = 3
    grid.gridwidth = 2
    gridbag.setConstraints(@user_combo, grid)
    content_pane.add(@user_combo)

    @user_combo.add_action_listener do |e|
      user_change @user_combo.getSelectedItem()
    end

    @connect_btn = JButton.new('Connect')
    grid.gridx = 0
    grid.gridy = 4
    gridbag.setConstraints(@connect_btn, grid)
    content_pane.add(@connect_btn)

    @connect_btn.add_action_listener do |e|
      connect_clicked
    end

    set_default_close_operation(JFrame::EXIT_ON_CLOSE)

    # don't set the size, let swing figure it out
    # set_preferred_size(Dimension.new(275, 175))

    # fill out the server and user boxes
    # based on the site setting
    site_change @site_combo.getSelectedItem
  end

  private


  def site_change(new_site)
    # remove all the servers for this site
    @host_combo.removeAllItems

    rval = ''
    # add new items
    @yaml_data['sessions'].each do |session|
      if new_site == session[0]['site']

        session[1].each_index do |i|
          @host_combo.addItem "#{session[1][i]['host']}"
        end

        # change the host to the first host setting
        rval = "#{session[1][0]['host']}"
        desc_change("#{session[1][0]['desc']}")
      end
    end

    host_change(rval)
  end

  def host_change(new_host)
    # remove all the users for this server
    @user_combo.removeAllItems
    rval = ''

    @yaml_data['sessions'].each do |session|
      if @site_combo.getSelectedItem == session[0]['site']

        session[1].each_index do |i|
          if new_host == "#{session[1][i]['host']}"

            session[1][i]['users'].each_index do |j|
              @user_combo.addItem session[1][i]['users'][j][0]['user']
            end

            # change the host to the first host setting
            rval = session[1][i]['users'][0][0]['user']
            desc_change("#{session[1][i]['desc']}")
          end
        end
      end
    end
    user_change(rval)
  end

  def desc_change(new_desc)
    @desc_data_lbl.setText(new_desc)
  end

  def user_change(new_user)
    @user_name_data = new_user
  end

  def connect_clicked


    ssh_cmd = "#{@connect_cmd_start} #{@identity_file} #{@user_combo.getSelectedItem}@#{@host_combo.getSelectedItem} #{@connect_cmd_end}"

    puts "Connect to host #{ssh_cmd}"

    thr = Thread.new { `#{ssh_cmd}` }

    @save_sub_process << thr
  end
end

SwingUtilities.invoke_later do
  TopFrame.new
end
