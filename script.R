data(iris)

iris <- iris[iris$Species != "versicolor", c("Species", "Petal.Length")]

x <- iris[iris$Species == "setosa", "Petal.Length"]
y <- iris[iris$Species == "virginica", "Petal.Length"]

tt <- t.test(x, y, var.equal = FALSE)

library(orkg)

orkg <- ORKG(host="https://orkg.org")
orkg$templates$materialize_template(template_id = "R12002")
tp = orkg$templates$list_templates()

instance <- tp$students_ttest(
  label='Statistically significant hypothesis test with petal length dependent variable on setosa and virginica irises', 
  has_dependent_variable='http://purl.obolibrary.org/obo/TO_0002605', # petal length
  has_specified_input=tuple(iris, 'Setosa and virginica petal length dataset'),
  has_specified_output=tp$pvalue('the p-value', 
    tp$scalar_value_specification(as.character(tt$p.value), tt$p.value)
  ),
)
instance$serialize_to_file('myarticle.contribution.1.json', format='json-ld')