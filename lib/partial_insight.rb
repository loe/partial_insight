module PartialInsight
  module InstanceMethods
    def compile_with_template_comment(template)
      src = compile_without_template_comment(template)
      if Rails.env.development?
        src.sub!(/@output_buffer = ''/, "@output_buffer='<!-- Start: #{template.filename} -->\n'")
        src << "\n@output_buffer.concat '<!-- End: #{template.filename} -->\n'"
      end
      
      src
    end
  end
  
  def self.included(receiver)
    receiver.send :include, InstanceMethods
    receiver.alias_method_chain :compile, :template_comment
  end
end