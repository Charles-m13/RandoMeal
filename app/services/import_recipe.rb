class ImportRecipe

  def initialize(url, tag = nil)
    @url = url
    @tag = tag
    @data = {}
  end

  def call
    fetch_data
    parse_doc
    extract_data
    create_recipe
    add_tag
  end

  private

  def fetch_data
    @html_file = URI.open(@url).read
  end

  def parse_doc
    @html_doc = Nokogiri::HTML(@html_file)
    json = @html_doc.at('script[type="application/ld+json"]').text
    @json_data = JSON.parse(json)
  end

  def extract_data
    ap "je suis dans extract_data"
    @data[:prep_time] = @json_data['prepTime'][2..-2]
    @data[:total_time] = @json_data['totalTime'][2..-2]
    @json_data['recipeIngredient'].each do |string|
      @data[:quantity] = string.match(/(^\d+)/)&.captures&.first
      @data[:name] = string.gsub(/(^\d+\s?)/, "")
    end
    @caract_recipe = []
    @html_doc.search('.RCP__sc-1qnswg8-1').each do |element|
      @caract_recipe << element.text.strip
    end
  end

  def create_recipe
    @recipe = Recipe.create!(
                      name: @json_data['name'],
                      image: @json_data['image'][0],
                      url_marmiton: @url,
                      price: @caract_recipe[2],
                      prep_duration: @data[:prep_time],
                      total_duration: @data[:total_time],
                      people: @json_data['recipeYield'],
                      all_ingredients: @json_data['recipeIngredient']
                    )
    add_ingredients
  end

  def add_tag
    return unless @tag

    @recipe_tag = RecipeTag.create!(
      tag: @tag,
      recipe: @recipe
    )
  end

  def add_ingredients
    @ingredient = Ingredient.create!(
      name: @data[:name],
      quantity:  @data[:quantity],
      recipe: @recipe
    )
  end
end
