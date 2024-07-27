""" Ubuntu 22.04 Profile for Embarcadero Setup

Instructions:
Start the experiment!
"""

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as rspec

IMAGE = 'urn:publicid:IDN+emulab.net+image+Escra:embarcadero-deps'

# Set up parameters
pc = portal.Context()
pc.defineParameter("nodeType", 
                   "Node Hardware Type",
                   portal.ParameterType.NODETYPE, 
                   "d430",
                   longDescription="A specific hardware type to use. This profile has primarily been tested with d430 nodes.")

# Below option copy/pasted directly from small-lan experiment on CloudLab
# Optional ephemeral blockstore
pc.defineParameter("tempFileSystemSize", 
                   "Temporary Filesystem Size",
                   portal.ParameterType.INTEGER, 
                   0,
                   advanced=True,
                   longDescription="The size in GB of a temporary file system to mount on each of your " +
                   "nodes. Temporary means that they are deleted when your experiment is terminated. " +
                   "The images provided by the system have small root partitions, so use this option " +
                   "if you expect you will need more space to build your software packages or store " +
                   "temporary files. 0 GB indicates maximum size.")
params = pc.bindParameters()

pc.verifyParameters()
request = pc.makeRequestRSpec()

node = request.RawPC("embarcadero")
node.disk_image = IMAGE
node.hardware_type = params.nodeType
  
# Add extra storage space
bs = node.Blockstore(name + "-bs", "/mydata")
bs.size = str(params.tempFileSystemSize) + "GB"
bs.placement = "any"

pc.printRequestRSpec()
