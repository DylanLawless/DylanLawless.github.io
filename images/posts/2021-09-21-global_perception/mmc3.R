# Data source: DOI:https://doi.org/10.1016/j.ajhg.2020.08.023
# Download Supplemental data (mmc3.xlsx) Table S2. Unadjusted Results for Full Dataset, Stratified by Country
# Convert data to tsv format.

data <- 
  read.table(file="mmc3.tsv", 
             header = TRUE, 
             sep = "\t")

require(tidyr)
data_l <- gather(data, cohort, value, 
       Total:United.States, na.rm = FALSE, convert = FALSE, factor_key = FALSE)

data_l_sep <- separate(data_l, value, 
                       sep = "\\(|\\)",
                            into = c("value", "samples"))

# Get variable names for filtering
unique(data_l_sep$Variable)

require(ggplot2)
# Figure 1. Willingness to Donate Anonymous DNA and Medical Information to Different Recipient Groups, Stratified by Country
df1 <- data_l_sep %>% 
  filter(Variable == "Willingness to donate to at least two recipient groups" |
           Variable == "Willingness to donate to non-profit researchers" |
           Variable == "Willingness to donate to for-profit researchers") %>%
  filter(Categories == "Yes") %>%
  group_by(Variable) 

df1 %>% 
ggplot(aes(x=factor(cohort), y=as.numeric(value), fill=factor(Variable))) + 
  geom_bar(stat="identity", position="dodge")+
  theme(axis.text.x = element_text( angle = 45, hjust = 1 ),
        legend.position="bottom", legend.direction="vertical") +
  labs(x = "Cohort", y = " Percentage willingness ",
       title ="Figure 1. Willingness to Donate Anonymous DNA and\nMedical Information to Different Recipient Groups")

# Figure 2 Familiarity with Genetics (Including Familiarity Gained through Personal Experience), Stratified by Country
df2 <- data_l_sep %>% 
  filter(Variable == "Familiarity with genetics") %>%
  filter(Categories == "Personal" | Categories == "Familiar" | Categories == "Unfamiliar") %>%
  group_by(Variable) 

df2 %>% 
  ggplot(aes(x=factor(cohort), y=as.numeric(value), fill=factor(Categories))) + 
  geom_bar(stat="identity", position="dodge")+
  theme(axis.text.x = element_text( angle = 45, hjust = 1 ),
        legend.position="bottom", legend.direction="vertical") +
  labs(x = "Cohort", y = " Percentage",
       title ="Figure 2 Familiarity with Genetics \nIncluding Familiarity Gained through Personal Experience")

# Figure 3 Perception of DNA as Being Different from Other Medical Information (Genetic Exceptionalism) versus DNA as Being the Same (or Unsure), Stratified by Country
df3 <- data_l_sep %>% 
  filter(Variable == "Perception of DNA being different to other medical information versus DNA being the same") %>%
  filter(Categories == "Same/Unsure" | Categories == "Different") %>%
  group_by(Variable) 

df3 %>% 
  ggplot(aes(x=factor(cohort), y=as.numeric(value), fill=factor(Categories))) + 
  geom_bar(stat="identity", position="dodge")+
  theme(axis.text.x = element_text( angle = 45, hjust = 1 ),
        legend.position="bottom", legend.direction="horizontal") +
  labs(x = "Cohort", y = " Percentage",
       title ="Figure 3 Perception of DNA as Being Different from\nOther Medical Information (Genetic Exceptionalism)\nversus DNA as Being the Same (or Unsure)")

# Figure 4 Trust in Donating DNA and Medical Information to More than One User (Including Doctor, Researcher, Company, Government, etc.), Stratified by Country
df4 <- data_l_sep %>% 
  filter(Variable == "Trust in donating DNA and medical information to more than one user") %>%
  group_by(Variable) 

df4 %>% 
  ggplot(aes(x=factor(cohort), y=as.numeric(value), fill=factor(Categories))) + 
  geom_bar(stat="identity", position="dodge")+
  theme(axis.text.x = element_text( angle = 45, hjust = 1 ),
        legend.position="bottom", legend.direction="horizontal") +
  labs(x = "Cohort", y = " Percentage",
       title ="Figure 4 Trust in Donating DNA and Medical Information to \nMore than One User (incl. Doctor, Researcher, Government, etc.)")
