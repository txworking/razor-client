# Root ProjectRazor namespace
module ProjectRazor
  class Slice
    # ProjectRazor Slice Node (NEW)
    # Used for policy management
    class Node < ProjectRazor::Slice
      # @param [Array] args
      def initialize(args)
        super(args)
        @hidden          = false
        @slice_name = "Node"
        #@engine = ProjectRazor::Engine.instance
        # get the slice commands map for this slice (based on the set
        # of commands that are typical for most slices); note that there is
        # no support for adding, updating, or removing nodes via the slice
        # API, so the last three arguments are nil
        @slice_commands = get_command_map("node_help", "get_all_nodes",
                                          "get_node_by_uuid", nil, nil, nil, nil)
        # and add a few more commands specific to this slice
        @slice_commands[["register", /^[Rr]$/]] = "register_node"
        @slice_commands[["checkin", /^[Cc]$/]] = "checkin_node"
        @slice_commands[:get][/^(?!^(all|\-\-help|\-h|\{\}|\{.*\}|nil)$)\S+$/][:else] = "get_node_by_uuid"
      end

      def node_help
        if @prev_args.length > 1
          command = @prev_args.peek(1)
          begin
            # load the option items for this command (if they exist) and print them
            option_items = load_option_items(:command => command.to_sym)
            print_command_help(@slice_name.downcase, command, option_items)
            return
          rescue
          end
        end
        # if here, then either there are no specific options for the current command or we've
        # been asked for generic help, so provide generic help
        puts get_node_help
      end

      def get_node_help
        return ["Node Slice: used to view the current list of nodes (or node details)".red,
                "Node Commands:".yellow,
                "\trazor node [get] [all]                      " + "Display list of nodes".yellow,
                "\trazor node [get] (UUID)                     " + "Display details for a node".yellow,
                "\trazor node [get] (UUID) [--field,-f FIELD]  " + "Display node's field values".yellow,
                "\trazor node --help                           " + "Display this screen".yellow,
                "  Note; the FIELD value (above) can be either 'attributes' or 'hardware_ids'".red].join("\n")
      end

      def get_all_nodes
        # Get all node instances and print/return
        @command = :get_all_nodes
        raise ProjectRazor::Error::Slice::SliceCommandParsingFailed,
              "Unexpected arguments found in command #{@command} -> #{@command_array.inspect}" if @command_array.length > 0
        # if it's a web command and the last argument wasn't the string "default" or "get", then a
        # filter expression was included as part of the web command
        @command_array.unshift(@prev_args.pop) if @web_command && @prev_args.peek(0) != "default" && @prev_args.peek(0) != "get"
        print_object_array get_object("nodes", :node), "Discovered Nodes", :style => :table
      end

      def get_node_by_uuid
        @command = :get_node_by_uuid
        includes_uuid = false
        # ran one argument far when parsing if we were working with a web command
        @command_array.unshift(@prev_args.pop) if @web_command
        # load the appropriate option items for the subcommand we are handling
        option_items = load_option_items(:command => :get)
        # parse and validate the options that were passed in as part of this
        # subcommand (this method will return a UUID value, if present, and the
        # options map constructed from the @commmand_array)
        node_uuid, options = parse_and_validate_options(option_items, "razor node [get] (UUID) [--field,-f FIELD]", :require_all)
        includes_uuid = true if node_uuid
        node = get_object("node_with_uuid", :node, node_uuid)
        raise ProjectRazor::Error::Slice::InvalidUUID, "no matching Node (with a uuid value of '#{node_uuid}') found" unless node && (node.class != Array || node.length > 0)
        selected_option = options[:field]
        # if no options were passed in, then just print out the summary for the specified node
        return print_object_array [node] unless selected_option
        if /^(attrib|attributes)$/.match(selected_option)
          get_node_attributes(node)
        elsif /^(hardware|hardware_id|hardware_ids)$/.match(selected_option)
          get_node_hardware_ids(node)
        else
          raise ProjectRazor::Error::Slice::InputError, "unrecognized fieldname '#{selected_option}'"
        end
      end

      def get_node_attributes(node)
        @command = :get_node_attributes
        if @web_command
          print_object_array [Hash[node.attributes_hash.sort]]
        else
          print_object_array node.print_attributes_hash, "Node Attributes:"
        end
      end

      def get_node_hardware_ids(node)
        @command = :get_node_hardware_ids
        if @web_command
          print_object_array [{"hw_id" => node.hw_id}]
        else
          print_object_array node.print_hardware_ids, "Node Hardware ID's:"
        end
      end
    end
  end
end


