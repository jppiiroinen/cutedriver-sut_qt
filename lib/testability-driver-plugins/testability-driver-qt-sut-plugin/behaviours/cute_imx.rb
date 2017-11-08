############################################################################
## 
## Copyright (C) 2017 Link Motion Oy
## Author(s): Juhapekka Piiroinen <juhapekka.piiroinen@link-motion.com>
##
## All rights reserved. 
## Contact: Link Motion (info@link-motion.com) 
## 
## This file is part of CuteDriver. 
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
        module Imx
            include MobyBehaviour::QT::Behaviour
            
            def gpu_usage
                results_xml = execute("gpu.usage.collect")
                state_object = @sut.state_object( results_xml )
                results = []
                count = state_object.logData.attribute( 'entryCount' ).to_i
                is_valid = state_object.logData.attribute( 'isValid' ).to_s == "1"
                for i in 0...count
                    meas_start = state_object.logEntry(:id => i.to_s).attribute('start').to_i
                    meas_end = state_object.logEntry(:id => i.to_s).attribute('end').to_i
                    meas_on = state_object.logEntry(:id => i.to_s).attribute('on').to_i
                    meas_off = state_object.logEntry(:id => i.to_s).attribute('off').to_i
                    meas_idle = state_object.logEntry(:id => i.to_s).attribute('idle').to_i
                    meas_suspend = state_object.logEntry(:id => i.to_s).attribute('suspend').to_i
                    meas_on_percentage = state_object.logEntry(:id => i.to_s).attribute('on_percentage').to_f
                    meas_off_percentage = state_object.logEntry(:id => i.to_s).attribute('off_percentage').to_f
                    meas_idle_percentage = state_object.logEntry(:id => i.to_s).attribute('idle_percentage').to_f
                    meas_suspend_percentage = state_object.logEntry(:id => i.to_s).attribute('suspend_percentage').to_f
                    entry = {
                        :value => meas_start,
                        :start => meas_start,
                        :end => meas_end,
                        :on => meas_on,
                        :off => meas_off,
                        :idle => meas_idle,
                        :suspend => meas_suspend,
                        :on_percentage => meas_on_percentage,
                        :off_percentage => meas_off_percentage,
                        :idle_percentage => meas_idle_percentage,
                        :suspend_percentage => meas_suspend_percentage,
                        :is_valid => is_valid,
                    }
                    results.push(entry)
                end
                results
            end
            
            def gpu_apps
                results_xml = execute("gpu.apps.collect")
                state_object = @sut.state_object( results_xml )
                results = []
                count = state_object.logData.attribute( 'entryCount' ).to_i
                is_valid = state_object.logData.attribute( 'isValid' ).to_s == "1"
                for i in 0...count
                    pid = state_object.logEntry(:id => i.to_s).attribute('pid').to_i
                    processName = state_object.logEntry(:id => i.to_s).attribute('processName')
                    entry = {
                        :value => processName,
                        :processName => processName,
                        :pid => pid,
                        :is_valid => is_valid,
                    }
                    results.push(entry)
                end
                results
            end

            def gpu_info
                results_xml = execute("gpu.info.collect")
                state_object = @sut.state_object( results_xml )
                results = []
                count = state_object.logData.attribute( 'entryCount' ).to_i
                is_valid = state_object.logData.attribute( 'isValid' ).to_s == "1"
                for i in 0...count
                    gpu = state_object.logEntry(:id => i.to_s).attribute('gpu').to_i
                    model = state_object.logEntry(:id => i.to_s).attribute('model').to_i
                    revision = state_object.logEntry(:id => i.to_s).attribute('revision').to_i
                    entry = {
                        :value => gpu,
                        :gpu => gpu,
                        :model => model,
                        :revision => revision,
                        :is_valid => is_valid,
                    }
                    results.push(entry)
                end
                results
            end

            def gpu_mem
                results_xml = execute("gpu.mem.collect")
                state_object = @sut.state_object( results_xml )
                results = []
                count = state_object.logData.attribute( 'entryCount' ).to_i
                is_valid = state_object.logData.attribute( 'isValid' ).to_s == "1"
                for i in 0...count
                    videomemory_gcvpool_system_used = state_object.logEntry(:id => i.to_s).attribute('videomemory_gcvpool_system_used').to_i
                    nonpagedmemory_gcvpool_virtual_used = state_object.logEntry(:id => i.to_s).attribute('nonpagedmemory_gcvpool_virtual_used').to_i
                    videomemory_gcvpool_contiguous_used = state_object.logEntry(:id => i.to_s).attribute('videomemory_gcvpool_contiguous_used').to_i
                    videomemory_gcvpool_system_free = state_object.logEntry(:id => i.to_s).attribute('videomemory_gcvpool_system_free').to_i
                    videomemory_gcvpool_virtual_used = state_object.logEntry(:id => i.to_s).attribute('videomemory_gcvpool_virtual_used').to_i
                    videomemory_gcvpool_system_total = state_object.logEntry(:id => i.to_s).attribute('videomemory_gcvpool_system_total').to_i
                    entry = {
                        :value => videomemory_gcvpool_system_used,
                        :videomemory_gcvpool_system_used => videomemory_gcvpool_system_used,
                        :nonpagedmemory_gcvpool_virtual_used => nonpagedmemory_gcvpool_virtual_used,
                        :videomemory_gcvpool_contiguous_used => videomemory_gcvpool_contiguous_used,
                        :videomemory_gcvpool_system_free => videomemory_gcvpool_system_free,
                        :videomemory_gcvpool_virtual_used => videomemory_gcvpool_virtual_used,
                        :videomemory_gcvpool_system_total => videomemory_gcvpool_system_total,
                        :is_valid => is_valid,
                    }
                    results.push(entry)
                end
                results
            end

            def gpu_version
                results_xml = execute("gpu.version.collect")
                state_object = @sut.state_object( results_xml )
                results = []
                count = state_object.logData.attribute( 'entryCount' ).to_i
                is_valid = state_object.logData.attribute( 'isValid' ).to_s == "1"
                for i in 0...count
                    version = state_object.logEntry(:id => i.to_s).attribute('version')
                    entry = {
                        :value => version,
                        :version => version,
                        :is_valid => is_valid,
                    }
                    results.push(entry)
                end
                results
            end

            # enable hooking for performance measurement & debug logging
            TDriver::Hooking.hook_methods( self ) if defined?( TDriver::Hooking )

        private
            def execute(command)
                res = nil
                begin
                    res = @sut.fixture( 'imx', command, {} )
                rescue Exception
                    $logger.behaviour "FAIL;Failed imx #{command};#{ command };imx #{command};"
                    raise
                end

                $logger.behaviour "PASS;Operation imx #{command} executed successfully.;#{ command };imx #{command};"
                res
            end
        end
    end
end
    