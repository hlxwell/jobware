# class Ability
#   include CanCan::Ability
# 
#   def initialize(user)
#     case user.role
#     when "admin"
#       can :manage, :all
#     when "company"
#       can :create, Company
#       can :update, Company do |company|
#         company.try(:user) == user
#       end
#     when "partner"
#       can :create, Partner
#       can :update, Partner do |partner|
#         partner.try(:user) == user
#       end
#     when "jobseeker"
#       can :create, Resume
#       can :update, Resume do |resume|
#         resume.try(:user) == user
#       end
#     else
#       can :read, :all
#     end
#   end
# end
