############################################################################
## 
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies). 
## All rights reserved. 
## Contact: Nokia Corporation (testabilitydriver@nokia.com) 
## 
## This file is part of TDriver. 
## 
## If you have questions regarding the use of this file, please contact 
## Nokia at testabilitydriver@nokia.com . 
## 
## This library is free software; you can redistribute it and/or 
## modify it under the terms of the GNU Lesser General Public 
## License version 2.1 as published by the Free Software Foundation 
## and appearing in the file LICENSE.LGPL included in the packaging 
## of this file. 
## 
############################################################################

module MobyBehaviour

  module QT

    # == description
    # Events specific behaviours
    #
    # == behaviour
    # QtEvents
    #
    # == requires
    # testability-driver-qt-sut-plugin
    #
    # == input_type
    # *
    #
    # == sut_type
    # qt
    #
    # == sut_version
    # *
    #
    # == objects
    # *;application
    #
	module Events

	  include MobyBehaviour::QT::Behaviour

	  # == description
	  # Enable event listening. You can specify which events you want to listen for by including the names of 
	  # those events separated by comma or integers if using user events. Use ALL if you want to listen for all 
	  # events but be aware that there will be a lot of events.
	  # \n
	  # The events listened need to be sent the object to which the enabling is done for e.g. sut.button.enable_events('ALL') 
	  # would listen to all events sent to the button. When disabling or getting the events the operation must be done to the same object.
	  #
      # == arguments
      # filter_array
      #  Array
      #   description: Array of the event named to listen
      #   example: ["Timer","MouseButtonPress","45677","67889"]
	  #
      # == returns
      # NilClass
      #   description: -
      #   example: -
      #
      # == exceptions
      # Exception
      #  description: In case of an error
      #    
	  def enable_events(filter_array = nil)

		begin
		  command = plugin_command #in qt_behaviour 
		  command.command_name( 'EnableEvents' )
		  params_str = ''
		  filter_array.each {|value| params_str << value << ','} if filter_array
		  command.command_params( 'EventsToListen' => params_str)
		  command.service( 'collectEvents' ) 
		  @sut.execute_command( command)

		rescue Exception => e

		  MobyUtil::Logger.instance.log "behaviour" , "FAIL;Failed enable_events with refresh \"#{filter_array.to_s}\".;#{ identity };enable_events;"
		  Kernel::raise e

		end

		MobyUtil::Logger.instance.log "behaviour" , "PASS;Operation enable_events executed successfully with refresh \"#{ filter_array.to_s }\".;#{ identity };enable_events;"
		nil
	  end

	  # == description
	  # Disables event listening on the target
	  #
      # == returns
      # NilClass
      #   description: -
      #   example: -
      #
      # == exceptions
      # Exception
      #  description: In case of an error
      #    
	  def disable_events()

		begin
		  command = plugin_command #in qt_behaviour
		  command.command_name( 'DisableEvents' )
		  command.service( 'collectEvents' )
		  @sut.execute_command( command)
		rescue Exception => e
		  MobyUtil::Logger.instance.log "behaviour" , "FAIL;Failed disable_events.;#{ identity };disable_events;"
		  Kernel::raise e 
		end 

		MobyUtil::Logger.instance.log "behaviour" , "PASS;Operation disable_events executed successfully.;#{ identity };disable_events;"
		nil
	  end

	  # == description
	  # Gets event list occured since the enabling of events
	  # \n
	  # The format of the xml string is the same as with the ui state.
	  #
      # == returns
      # String
      #   description: Xml listing containing the details of the events logger since enable_events
      #   example: -
      #
      # == exceptions
      # Exception
      #  description: In case of an error
      #    
	  def get_events()
		ret = nil

		begin

		  command = plugin_command(true) #in qt_behaviour 
		  command.command_name( 'GetEvents' )
		  command.service( 'collectEvents' )
		  ret = @sut.execute_command( command)
		  # TODO: how to parse the output?

		rescue Exception => e

		  MobyUtil::Logger.instance.log "behaviour" , "FAIL;Failed get_events.;#{ identity };get_events;"
		  Kernel::raise e

		end

		MobyUtil::Logger.instance.log "behaviour" , "PASS;Operation get_events executed successfully.;#{ identity };get_events;"
		return ret
	  end

	  # enable hooking for performance measurement & debug logging
	  MobyUtil::Hooking.instance.hook_methods( self ) if defined?( MobyUtil::Hooking )

	end # EventsBehaviour

  end

end # MobyBase
