require 'java_imports.rb'

class TopFrame < JFrame

  def initialize
    super "SSH Connections"
    init_ui_components()
    pack()
    set_visible(true)
  end

  def init_ui_components()

    contentPane = getContentPane()
    gridbag = GridBagLayout.new
    contentPane.setLayout gridbag

    grid = GridBagConstraints.new

    #setting a default constraint value
    grid.fill = GridBagConstraints::HORIZONTAL

#    cb = JCheckBox.new "Show Title", true
#    cb.setBounds 50, 60, 80, 30
#    cb.setFocusable(false)
#
#    cb.add_action_listener do |e|
#      if self.getTitle.empty?
#        self.setTitle "JCheckBox example"
#      else
#        self.setTitle ""
#      end
#    end
#
#    add cb

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
    siteCombo.addItem "development"
    siteCombo.addItem "alpha"
    siteCombo.addItem "beta"
    siteCombo.addItem "production"
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
