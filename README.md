## EasyPost Label Printing Example

The [EasyPost API](https://www.easypost.com/getting-started) provides an easy
way to programatically create shipments and postage labels. This project
demonstrates combining the EasyPost APIs with [PrintNode](https://www.printnode.com/)
to easily print out any labels generated with your EasyPost account.

The application provides a minimal web application that can be hosted on any
computer, and will remotely send ZPL labels to any PrintNode enabled printer.

### Requirements

1. A Windows or Mac computer running [Ruby](https://www.ruby-lang.org/en/)
   [Bundler](http://bundler.io/) (it must be able to run the PrintNode client) 
1. Some type of printer that supports ZPL files (we used a Zebra ZP450)
1. An [EasyPost account](https://www.easypost.com/signup)
1. A [PrintNode account](https://app.printnode.com/account/register)

### Printer Setup

PrintNode has clear [documentation on getting your printer set up](https://www.printnode.com/docs/introduction/) 
so if you encounter any issues, refer there for more details.

1. Download and install the [PrintNode client](https://www.printnode.com/download/)
1. Plug in your printer
1. On OSX we manually added our printer with the below steps:
    1. Open a terminal and run `lpinfo -v | grep usb` to find your plugged in
       printer. It should return a line that looks something like:
       `direct usb://Zebra%20Technologies/ZTC%20ZP%20450-200dpi?serial=XXXXXXXXXXXX`
    1. Run `lpadmin -p raw_zebra -E -v usb://Zebra%20Technologies/ZTC%20ZP%20450-200dpi?serial=XXXXXXXXXXXX`
       in your terminal to install the printer with the name `raw_zebra`. You will
       need to replace the `usb://Zebra%20Technologies/ZTC%20ZP%20450-200dpi?serial=XXXXXXXXXXXX`
       with what the previous command returned for you.
    1. Once this is all set, you should see a new entry on your PrintNode 
       [Printers list](https://app.printnode.com/account/printer)


### Running the Application

1. Check out this repo and `cd` into the project directory
1. Copy or rename the sample.env to .env, and fill in values for
    1. [your EasyPost Api Key](https://www.easypost.com/account#/api-keys)
    1. [your PrintNode API Key](https://app.printnode.com/account/apiKey)
    1. [your printer's PrintNode Id](https://app.printnode.com/account/printer)
1. Run `bundle install`
1. Run `rackup`
1. The application should be up and running at <http://localhost:9292/>


### Troubleshooting

Occasionally, our printer would be showing up on PrintNode, but would fail to
print files. In these situations, a quick power cycle of the printer took care
of any issue.

If you still run into problems, you can try removing your printer and re-adding
it. If you're on OSX and followed the instructions above, just run
`lpadmin -x raw_zebra` to remove the printer.

If you aren't seeing any labels, make sure you have bought some postage on
EasyPost! You can walk through the
[EasyPost Getting Started Guide](https://www.easypost.com/getting-started) using
your test API Key and you won't be charged.

