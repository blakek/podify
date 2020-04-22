module Downloader
  class FetchSourceJob
    include Sidekiq::Worker
    include Dry::Monads[:result]

    include Podify::Import['downloader.fetch_source']

    def perform(source_id)
      source = Source[source_id]
      return unless source

      fetch_source.call(source).or do |failure|
        case failure
        when Dry::Validation::Result
          ap failure.errors.to_h
        else
          raise "Failed (#{failure})"
        end
      end
    end
  end
end