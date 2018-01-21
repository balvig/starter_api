module LifeboxesApi
  class Kitchenbox
    def to_json
      {
        recipe: recipe_markdown
      }.to_json
    end

    private

      def recipe_markdown
        <<~MARKDOWN
        World's Best Bread (tm)

        ---

        - Mix 500ml water, yeast (1/4 tsp dry), and 2tsp salt with 625g flour.

        - Cover and rise for 12 hours. Fold in thirds, rise 2 hours in bowl with oil/flour.

        - Preheat pot at 250C, bake 30mins with lid, bake 15mins at 230 without lid.
        MARKDOWN
      end
  end
end
