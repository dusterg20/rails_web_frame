# frozen_string_literal: true

module Devices
  # Devices::NewHTML
  class ShowHTML < BaseViewModel

    def device_display
      @devices.each do |dev|
        <td>dev.dev_name</td><td>
      end
    end
  end
end
