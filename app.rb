require 'sinatra/base'
require 'easypost'
require 'printnode'
require 'tilt/erb'
require 'dotenv'

require './lib/printlabel/helpers'

class App < Sinatra::Base

  configure do
    Dotenv.load

    EasyPost.api_key = ENV['EASYPOST_API_KEY']

    set :printnode_client, PrintNode::Client.new(PrintNode::Auth.new(ENV["PRINTNODE_API_KEY"]))
    set :printer_id, ENV['PRINTNODE_PRINTER_ID']
  end

  helpers PrintLabel::Helpers

  get "/shipments" do
    opts = {}
    if params["before_id"]
      opts.merge!(before_id: params["before_id"])
    elsif params["after_id"]
      opts.merge!(after_id: params["after_id"])
    end

    shipments = ::EasyPost::Shipment.all(opts)
    redirect back if shipments.shipments.count == 0
    erb :shipments, locals: {shipments: shipments}
  end

  get "/shipments/:shipment_id/zpl/generate" do
    shipment = ::EasyPost::Shipment.retrieve(params['shipment_id'])
    shipment.label(file_format: "ZPL") unless shipment.postage_label.label_zpl_url
    redirect back
  end

  get "/shipments/:shipment_id/zpl/print" do
    shipment = ::EasyPost::Shipment.retrieve(params['shipment_id'])
    printjob = PrintNode::PrintJob.new(settings.printer_id,
                                       shipment.id,
                                       'raw_uri',
                                       shipment.postage_label.label_zpl_url,
                                       'PrintLabel')
    settings.printnode_client.create_printjob(printjob, {})
    redirect back
  end

  get "/" do
    redirect "/shipments"
  end

  # run if this file is executed directly
  run! if app_file == $0
end
