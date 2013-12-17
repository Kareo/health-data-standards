module HealthDataStandards
  module Export
    class Cat3
      def initialize
        template_helper = HealthDataStandards::Export::TemplateHelper.new('cat3', 'cat3')
        @rendering_context = HealthDataStandards::Export::RenderingContext.new
        @rendering_context.template_helper = template_helper
        @cat1_renderer = HealthDataStandards::Export::RenderingContext.new
        @cat1_renderer.template_helper = HealthDataStandards::Export::TemplateHelper.new('cat1', 'cat1')
      end

      def export(measures, header, effective_date, start_date, end_date, filter=nil,test_id=nil)
        results = {}
        
        qc = HealthDataStandards::CQM::QueryCache
        
        collected_measures = measures.inject({}) {|agg, measure| (agg[measure.hqmf_id] ||= []) << measure }
        results = (collected_measures.map do |hqmf_id, measures|
          # Any stratified measures means everything should be aggregated
          if measures.any?(&:is_stratified?)
            aggregates = [qc.aggregate_measure(measure.hqmf_id, effective_date, filter, test_id)]
          else
            aggregates = measures.map {|m| qc.aggregate_measure(m.hqmf_id, effective_date, filter, test_id, m.sub_id)}
          end
          
          [hqmf_id, aggregates]
        end).to_hash
        
        @rendering_context.render(:template => 'show', 
                                  :locals => {:measures => measures, :start_date => start_date, 
                                              :end_date => end_date, :cat1_renderer => @cat1_renderer,
                                              :results => results,
                                              :header=>header})
      end
    end
  end
end