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
        qc = HealthDataStandards::CQM::QueryCache

        collected_measures = measures.group_by(&:hqmf_id)
        
        results = Hash[
            collected_measures.map do |hqmf_id, measures|
              aggregate_groups = measures.group_by{|m| m.stratification_id || NOT_STRATIFIED}
              
              # All non-stratified measures are individually processed
              aggregates = aggregate_groups.delete(NOT_STRATIFIED).map do |m|
                qc.aggregate_measure(hqmf_id, effective_date, filter, test_id, sub_id: m.sub_id)
              end
              
              # Everything else is grouped by stratification id
              aggregates << aggregate_groups.map do |strat_id, measures|
                qc.aggregate_measure(hqmf_id, effective_date, filter, test_id, strat_id: strat_id)
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