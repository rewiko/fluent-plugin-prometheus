require 'spec_helper'
require 'fluent/test/driver/input'
require 'fluent/plugin/in_prometheus_tail_monitor'

describe Fluent::Plugin::PrometheusTailMonitorInput do
  MONITOR_CONFIG = %[
  @type prometheus_tail_monitor
]

  describe '#configure' do
    before :all do
      @config = MONITOR_CONFIG
      @driver = Fluent::Test::Driver::Input.new(Fluent::Plugin::PrometheusTailMonitorInput).configure(@config) 
      @registry= ::Prometheus::Client.registry
      @driver.run() 
    end

    describe 'valid' do
      it 'does not raise error' do
        expect{@driver}.not_to raise_error
      end
    end

    context 'standard config' do

      it 'should contains fluentd_tail_file_inode' do
        name = "fluentd_tail_file_inode".to_sym
        expect(@registry.metrics.map(&:name)).to include(name)
      end

      it 'should contains fluentd_tail_file_position' do
        name = "fluentd_tail_file_position".to_sym
        expect(@registry.metrics.map(&:name)).to include(name)
      end

      it 'should contains fluentd_tail_file_size' do
        name = "fluentd_tail_file_size".to_sym
        expect(@registry.metrics.map(&:name)).to include(name)
      end

    end
  end
end