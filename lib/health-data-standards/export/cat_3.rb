module HealthDataStandards
  module Export
    class Cat3
      
      NOT_STRATIFIED = "<not stratified>"
      
      def initialize
        template_helper = HealthDataStandards::Export::TemplateHelper.new('cat3', 'cat3')
        @rendering_context = HealthDataStandards::Export::RenderingContext.new
        @rendering_context.template_helper = template_helper
        @cat1_renderer = HealthDataStandards::Export::RenderingContext.new
        @cat1_renderer.template_helper = HealthDataStandards::Export::TemplateHelper.new('cat1', 'cat1')
      end

      def export(measures, header, effective_date, start_date, end_date, filter=nil,test_id=nil)
        collected_measures = measures.group_by(&:hqmf_id)
        
        results = Hash[
          collected_measures.map do |hqmf_id, measures|
            # First, group all stratifications w/ their top-level population sub-measures.
            if measures.count{|m| !m.is_stratified?} == 1
              # This is chlamydia style case where there is no real tie-in between strats and top-level
              aggregate_groups = measures
              
            else
              # This is the weight assessment style case where a group critieria exists.
              # Anything with only non-stratified sub-measures will pass through here without a problem. 
              aggregate_groups = measures.group_by do |measure|
                if measure.is_stratified?
                  # Strip trailing ", RS#: ##-##" style suffix of weight assessment stratified sub-measures.
                  measure.subtitle.gsub(/,[^,]+$/, '')
                else
                  measure.subtitle
                end
              end
            end

            # Generate aggregates in what is hopefully groups of 1 top level sub-measure and 0+ stratifications
            # associated with that.
            aggregates = aggregate_groups.map do |group_critieria, measures|
              HealthDataStandards::CQM::QueryCache.aggregate_measure(hqmf_id, effective_date, filter, test_id, 
                                                                     measures: measures)
            end

            [hqmf_id, aggregates]
          end
        ]
        
        @rendering_context.render(:template => 'show', 
                                  :locals => {:measures => measures, :start_date => start_date, 
                                              :end_date => end_date, :cat1_renderer => @cat1_renderer,
                                              :results => results,
                                              :header=>header})
      end
    end
  end
end